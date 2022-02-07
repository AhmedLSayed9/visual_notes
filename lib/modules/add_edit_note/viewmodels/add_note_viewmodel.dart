import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/date_parser.dart';
import 'package:visual_notes/core/services/date_picker.dart';
import 'package:visual_notes/core/services/image_selector.dart';
import 'package:visual_notes/core/services/navigation_service.dart';
import 'package:visual_notes/core/utils/dialogs.dart';
import 'package:visual_notes/core/utils/validators.dart';
import 'package:visual_notes/core/widgets/snack_bar.dart';
import 'package:visual_notes/modules/home/models/visual_note_model.dart';
import 'package:visual_notes/modules/home/repos/notes_repo.dart';
import 'package:visual_notes/modules/home/viewmodels/notes_viewmodel.dart';

final addNoteViewModel = ChangeNotifierProvider.family
    .autoDispose<AddNoteViewModel, VisualNoteModel?>(
  (ref, visualNote) => AddNoteViewModel(ref, visualNote),
);

class AddNoteViewModel extends ChangeNotifier {
  AddNoteViewModel(this.ref, this.visualNoteModel) {
    notesRepo = ref.read(notesRepoProvider);
    if (visualNoteModel != null) {
      noteIdController.text = visualNoteModel!.noteId;
      noteTitleController.text = visualNoteModel!.title;
      noteDescriptionController.text = visualNoteModel!.description;
      noteDate =
          DateParser.instance.convertEpochToLocalDate(visualNoteModel!.date);
      noteStatus = visualNoteModel!.status;
    }
  }

  Ref ref;
  bool isLoading = false;
  late NotesRepo notesRepo;
  final VisualNoteModel? visualNoteModel;

  final formKey = GlobalKey<FormState>();
  TextEditingController noteIdController = TextEditingController();
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();
  File? noteImage;
  DateTime? noteDate;
  String? noteStatus;

  /// Validators

  bool validateNote() {
    if (formKey.currentState!.validate()) {
      if (validateUniqueID()) {
        return validateNoteInputs();
      }
    }
    return false;
  }

  String? validateID(String? value) {
    return Validators.instance.validateInteger(value);
  }

  String? validateTitle(String? value) {
    return Validators.instance.validateTitle(value);
  }

  String? validateDescription(String? value) {
    return Validators.instance.validateDescription(value);
  }

  bool validateUniqueID() {
    bool _isUniqueID = true;
    ref.read(notesViewModel).notesList.forEach((note) {
      if (note.noteId == noteIdController.text &&
          note.noteId != visualNoteModel?.noteId) {
        CustomSnackBar.showCommonRawSnackBar(
          Get.context!,
          title: tr('idAlreadyExist'),
          description: tr('pleaseAddDifferentNoteID'),
        );
        _isUniqueID = false;
      }
    });
    return _isUniqueID;
  }

  bool validateNoteInputs() {
    bool _validate = false;
    if (noteImage == null && visualNoteModel == null) {
      CustomSnackBar.showCommonRawSnackBar(
        Get.context!,
        title: tr('noImageSelected'),
        description: tr('pleaseSelectNoteImage'),
      );
    } else if (noteDate == null) {
      CustomSnackBar.showCommonRawSnackBar(
        Get.context!,
        title: tr('noDateSelected'),
        description: tr('pleaseSelectNoteDate'),
      );
    } else if (noteStatus == null) {
      CustomSnackBar.showCommonRawSnackBar(
        Get.context!,
        title: tr('noStatusSelected'),
        description: tr('pleaseSelectNoteStatus'),
      );
    } else {
      _validate = true;
    }
    return _validate;
  }

  /// Input Pickers

  Future pickNoteImage({required bool fromCamera}) async {
    noteImage = await ImageSelector.instance.pickImage(
      fromCamera: fromCamera,
    );
    notifyListeners();
  }

  pickNoteDate({
    required BuildContext context,
  }) async {
    final _selectedDate =
        await DatePicker.instance.selectDate(context, initialDate: noteDate);
    if (_selectedDate != null) {
      final _selectedTime =
          await DatePicker.instance.selectTime(context, initialDate: noteDate);
      if (_selectedTime != null) {
        noteDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  pickNoteStatus(String? value) {
    noteStatus = value!;
    notifyListeners();
  }

  /// Save & Update Note

  Future saveNote() async {
    isLoading = true;
    notifyListeners();
    try {
      final _imagePath = await saveImageToLocalStorage();
      await notesRepo.addNote(
        visualNoteModel: VisualNoteModel(
          noteId: noteIdController.text,
          date: DateParser.instance.convertDateToUTCEpoch(noteDate!),
          title: noteTitleController.text,
          description: noteDescriptionController.text,
          image: _imagePath!,
          status: noteStatus!,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
    ref.read(notesViewModel).getNotes();
    NavigationService.goBack();
  }

  Future<String?> saveImageToLocalStorage() async {
    final _storedImage = await ImageSelector.instance.saveImageLocally(
      imageFile: noteImage ?? File(visualNoteModel!.image),
      fileName: noteIdController.text,
    );
    return _storedImage;
  }

  bool isIdUpdated() {
    //If id changed we should upload image with new id & delete old image.
    return visualNoteModel!.noteId != noteIdController.text;
  }

  Future updateNote() async {
    isLoading = true;
    notifyListeners();
    try {
      final _imagePath = noteImage != null || isIdUpdated()
          ? await saveImageToLocalStorage()
          : visualNoteModel!.image;
      await notesRepo.updateNote(
        visualNoteModel: VisualNoteModel(
          noteId: noteIdController.text,
          date: DateParser.instance.convertDateToUTCEpoch(noteDate!),
          title: noteTitleController.text,
          description: noteDescriptionController.text,
          image: _imagePath!,
          status: noteStatus!,
        ),
        oldNoteId: visualNoteModel!.noteId,
      );
      if (isIdUpdated()) {
        await deleteOldImageFromLocalStorage();
      } else {
        //Clear ImageCache if new image uploaded with same id, this ensure image update on UI.
        ImageSelector.instance.clearImageCache();
      }
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
    ref.read(notesViewModel).getNotes();
    NavigationService.goBack();
  }

  Future deleteOldImageFromLocalStorage() async {
    await ImageSelector.instance.deleteImageLocally(
      imageFile: File(visualNoteModel!.image),
    );
  }
}
