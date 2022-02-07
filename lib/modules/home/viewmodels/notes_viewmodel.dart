import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_notes/core/services/image_selector.dart';
import 'package:visual_notes/core/utils/dialogs.dart';
import 'package:visual_notes/modules/home/models/visual_note_model.dart';
import 'package:visual_notes/modules/home/repos/notes_repo.dart';

final notesViewModel =
    ChangeNotifierProvider<NotesViewModel>((ref) => NotesViewModel(ref));

class NotesViewModel extends ChangeNotifier {
  NotesViewModel(this.ref) {
    notesRepo = ref.read(notesRepoProvider);
    getNotes();
  }

  bool isLoading = false;
  Ref ref;
  late NotesRepo notesRepo;

  List<VisualNoteModel> notesList = [];
  List<String> selectedNotesIds = [];

  getNotes() async {
    isLoading = true;
    notifyListeners();
    try {
      notesList = await notesRepo.getAllNotes();
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteNote({required VisualNoteModel visualNoteModel}) async {
    isLoading = true;
    notifyListeners();
    try {
      notesList.removeWhere((note) => note.noteId == visualNoteModel.noteId);
      notesRepo.deleteNote(noteId: visualNoteModel.noteId);
      ImageSelector.instance
          .deleteImageLocally(imageFile: File(visualNoteModel.image));
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteSelectedNotes() {
    isLoading = true;
    notifyListeners();
    try {
      deleteSelectedNotesLocalImages();
      notesList.removeWhere((note) => isSelectedNote(noteId: note.noteId));
      notesRepo.deleteMultipleNotes(notesIds: selectedNotesIds);
      clearNoteSelection();
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteSelectedNotesLocalImages() {
    final _selectedNotesImages = notesList
        .where((note) => isSelectedNote(noteId: note.noteId))
        .map((e) => e.image)
        .toList();
    for (var image in _selectedNotesImages) {
      ImageSelector.instance.deleteImageLocally(imageFile: File(image));
    }
  }

  bool isSelectedNote({required String noteId}) {
    if (selectedNotesIds.contains(noteId)) {
      return true;
    } else {
      return false;
    }
  }

  toggleNoteSelection({required String noteId}) {
    if (selectedNotesIds.contains(noteId)) {
      selectedNotesIds.remove(noteId);
    } else {
      selectedNotesIds.add(noteId);
    }
    notifyListeners();
  }

  clearNoteSelection() {
    selectedNotesIds.clear();
    notifyListeners();
  }
}
