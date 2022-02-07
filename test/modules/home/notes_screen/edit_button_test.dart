import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:visual_notes/modules/add_edit_note/screens/add_edit_note_screen.dart';
import 'package:visual_notes/modules/home/components/edit_button_component.dart';
import 'package:visual_notes/modules/home/components/note_list_item_component.dart';
import 'package:visual_notes/modules/home/repos/notes_repo.dart';
import 'package:visual_notes/modules/home/screens/visual_notes_screen.dart';
import 'notes_repo.mocks.dart';
import '../my_app.dart';
import '../notes_dummy_data.dart';

@GenerateMocks([NotesRepo])
void main() {
  late MockNotesRepo client;

  setUpAll(() {
    client = MockNotesRepo();
  });

  testWidgets(
      'Given notes When click on edit button Then navigate to edit screen',
      (tester) async {
    // ARRANGE
    when(client.getAllNotes()).thenAnswer((_) async => [
          dummyNotes[0],
          dummyNotes[1],
        ]);
    when(client.deleteNote(noteId: anyNamed('noteId')))
        .thenAnswer((_) async => null);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notesRepoProvider.overrideWithValue(client),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump();
    final noteItemComponent = find.byType(NoteListItemComponent);
    expect(noteItemComponent, findsNWidgets(2));

    // ACT
    await tester.tap(find.byType(EditButtonComponent).first);
    await tester.pumpAndSettle();
    // ASSERT
    expect(find.byType(AddEditNoteScreen), findsOneWidget);
    expect(find.text('editNote'), findsOneWidget);

    // ACT
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle();
    // ASSERT
    expect(find.byType(AddEditNoteScreen), findsNothing);
    expect(find.byType(VisualNotesScreen), findsOneWidget);
  });
}
