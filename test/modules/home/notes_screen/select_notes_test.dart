import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/modules/home/components/multi_selection_header_component.dart';
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

  group('select notes cases', () {
    testWidgets('Given notes When long tap on notes Then select/unselect notes',
        (tester) async {
      // ARRANGE
      when(client.getAllNotes()).thenAnswer((_) async => [
            dummyNotes[0],
            dummyNotes[1],
          ]);
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
      final _note1 = find.byKey(const Key('noteId1'));
      final _note2 = find.byKey(const Key('noteId2'));
      final _selectedItems = find.byKey(const Key('selectedItems'));
      final _clearSelectedItems = find.byKey(const Key('clearSelectedItems'));

      // ACT & ASSERT
      await tester.longPress(_note1);
      await tester.pump();
      expect(find.byType(MultiSelectionHeaderComponent), findsOneWidget);
      expect(
        tester.widget(_selectedItems),
        isA<CustomText>().having((t) => (t.child as Text).data, 'data', '1'),
      );
      await tester.ensureVisible(_note2);
      await tester.pump();
      await tester.tap(_note2);
      await tester.pump();
      expect(
        tester.widget(_selectedItems),
        isA<CustomText>().having((t) => (t.child as Text).data, 'data', '2'),
      );
      await tester.tap(_note2);
      await tester.pump();
      expect(
        tester.widget(_selectedItems),
        isA<CustomText>().having((t) => (t.child as Text).data, 'data', '1'),
      );
      await tester.tap(_clearSelectedItems);
      await tester.pump();
      expect(_selectedItems, findsNothing);
    });
  });
}
