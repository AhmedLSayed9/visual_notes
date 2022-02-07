import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/modules/home/components/note_list_item_component.dart';
import 'package:visual_notes/modules/home/repos/notes_repo.dart';
import 'notes_repo.mocks.dart';
import '../my_app.dart';
import '../notes_dummy_data.dart';

@GenerateMocks([NotesRepo])
void main() {
  late MockNotesRepo client;

  setUpAll(() {
    client = MockNotesRepo();
  });

  group('delete notes cases', () {
    testWidgets('Given notes When dismiss note Then delete it', (tester) async {
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
      final noteItem1 = find.byKey(const Key('noteId1'));

      // ACT
      await tester.drag(noteItem1, const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      // ASSERT
      expect(noteItemComponent, findsNWidgets(1));
      expect(noteItem1, findsNothing);
    });

    testWidgets(
        'Given notes When select notes and press delete Then delete selected notes and clear selection',
        (tester) async {
      // ARRANGE
      when(client.getAllNotes()).thenAnswer((_) async => [
            dummyNotes[0],
            dummyNotes[1],
          ]);
      when(client.deleteMultipleNotes(notesIds: anyNamed('notesIds')))
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
      final noteItem1 = find.byKey(const Key('noteId1'));
      final noteItem2 = find.byKey(const Key('noteId2'));
      final selectedItems = find.byKey(const Key('selectedItems'));
      final deleteItemsButton = find.byKey(const Key('deleteItemsButton'));

      // ACT
      await tester.longPress(noteItem1);
      await tester.pump();
      await tester.ensureVisible(noteItem2);
      await tester.pump();
      await tester.tap(noteItem2);
      await tester.pump();
      expect(
        tester.widget(selectedItems),
        isA<CustomText>().having((t) => (t.child as Text).data, 'data', '2'),
      );
      await tester.tap(deleteItemsButton);
      await tester.pump();

      // ASSERT
      expect(selectedItems, findsNothing);
      expect(noteItemComponent, findsNothing);
    });
  });
}
