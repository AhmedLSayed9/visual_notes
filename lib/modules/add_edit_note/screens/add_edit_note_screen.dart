import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_notes/core/components/appbar_with_icon_component.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/screens/popup_page.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_button.dart';
import 'package:visual_notes/core/widgets/loading_indicators.dart';
import 'package:visual_notes/modules/add_edit_note/components/add_note_text_field_component.dart';
import 'package:visual_notes/modules/add_edit_note/components/note_date_component.dart';
import 'package:visual_notes/modules/add_edit_note/components/note_image_component.dart';
import 'package:visual_notes/modules/add_edit_note/components/note_status_component.dart';
import 'package:visual_notes/modules/add_edit_note/viewmodels/add_note_viewmodel.dart';
import 'package:visual_notes/modules/home/models/visual_note_model.dart';

class AddEditNoteScreen extends ConsumerWidget {
  final VisualNoteModel? visualNoteModel;

  const AddEditNoteScreen({
    required this.visualNoteModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final bool isNewNote = visualNoteModel == null;
    final addNoteVM = ref.watch(addNoteViewModel(visualNoteModel));

    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.addNoteScreenIcon,
          title: isNewNote ? tr('addNewNote') : tr('editNote'),
        ),
      ],
      resizeToAvoidBottomInset: true,
      child: addNoteVM.isLoading
          ? LoadingIndicators.instance.smallLoadingAnimation(context)
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.screenVPaddingDefault,
                  horizontal: Sizes.screenHPaddingDefault,
                ),
                child: Form(
                  key: addNoteVM.formKey,
                  child: Column(
                    children: <Widget>[
                      NoteImageComponent(
                        addNoteVM: addNoteVM,
                      ),
                      SizedBox(
                        height: Sizes.vMarginMedium,
                      ),
                      NoteDateComponent(
                        addNoteVM: addNoteVM,
                      ),
                      SizedBox(
                        height: Sizes.vMarginMedium,
                      ),
                      AddNoteTextFieldComponent(
                        title: tr('noteId'),
                        hint: tr('enterNoteId'),
                        controller: addNoteVM.noteIdController,
                        validator: addNoteVM.validateID(),
                        keyboardType: TextInputType.number,
                      ),
                      AddNoteTextFieldComponent(
                        title: tr('noteTitle'),
                        hint: tr('enterNoteTitle'),
                        controller: addNoteVM.noteTitleController,
                        validator: addNoteVM.validateTitle(),
                        keyboardType: TextInputType.text,
                      ),
                      AddNoteTextFieldComponent(
                        title: tr('noteDescription'),
                        hint: tr('enterNoteDescription'),
                        controller: addNoteVM.noteDescriptionController,
                        validator: addNoteVM.validateDescription(),
                        keyboardType: TextInputType.multiline,
                        isMultiLine: true,
                        maxLines: 4,
                      ),
                      NoteStatusComponent(
                        addNoteVM: addNoteVM,
                      ),
                      SizedBox(
                        height: Sizes.vMarginHighest,
                      ),
                      CustomButton(
                        text: isNewNote ? tr('add') : tr('done'),
                        onPressed: () {
                          if (addNoteVM.validateNote()) {
                            if (isNewNote) {
                              addNoteVM.saveNote();
                            } else {
                              addNoteVM.updateNote();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
