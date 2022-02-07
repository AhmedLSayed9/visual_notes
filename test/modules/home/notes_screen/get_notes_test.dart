import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:visual_notes/modules/home/components/note_list_item_component.dart';
import 'package:visual_notes/modules/home/repos/notes_repo.dart';
import 'notes_repo.mocks.dart';
import '../my_app.dart';
import '../notes_dummy_data.dart';

void main() {
  late MockNotesRepo client;

  setUpAll(() {
    client = MockNotesRepo();
  });

  group('get notes cases', () {
    testWidgets(
        'Given empty notes When notes screen open Then show loading animation then show text',
        (tester) async {
      // ARRANGE
      when(client.getAllNotes()).thenAnswer((_) async => []);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notesRepoProvider.overrideWithValue(client),
          ],
          child: const MyApp(),
        ),
      );

      // ACT & ASSERT
      final loadingAnimation = find.byKey(const Key('smallLoadingAnimation'));
      expect(loadingAnimation, findsOneWidget);
      await tester.pump();
      expect(loadingAnimation, findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(find.byKey(const Key('noVisualNotes')), findsOneWidget);
    });

    testWidgets(
        'Given 1 note When notes screen open Then show loading animation then show listview with 1 note',
        (tester) async {
      // ARRANGE
      when(client.getAllNotes()).thenAnswer((_) async => [
            dummyNotes[0],
          ]);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notesRepoProvider.overrideWithValue(client),
          ],
          child: const MyApp(),
        ),
      );

      // ACT & ASSERT
      final loadingAnimation = find.byKey(const Key('smallLoadingAnimation'));
      final noteItemComponent = find.byType(NoteListItemComponent);
      expect(loadingAnimation, findsOneWidget);
      await tester.pump();
      expect(loadingAnimation, findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(noteItemComponent, findsOneWidget);
      expect(tester.widgetList(noteItemComponent), [
        isA<NoteListItemComponent>().having((v) => v.visualNoteModel.noteId,
            'visualNoteModel.noteId', 'noteId1'),
      ]);
    });
  });
}
