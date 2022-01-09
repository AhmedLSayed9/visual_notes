import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_notes/core/components/main_drawer.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/screens/popup_page.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/core/widgets/loading_indicators.dart';
import 'package:visual_notes/modules/home/components/multi_selection_header_component.dart';
import 'package:visual_notes/modules/home/components/note_dismiss_background_component.dart';
import 'package:visual_notes/modules/home/components/note_list_item_component.dart';
import 'package:visual_notes/modules/home/viewmodels/notes_viewmodel.dart';

class VisualNotesScreen extends ConsumerWidget {
  VisualNotesScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ref) {
    final notesVM = ref.watch(notesViewModel);
    return PopUpPage(
      scaffoldKey: scaffoldKey,
      appBarWithMenu: true,
      appbarItems: [
        CustomText.h2(
          context,
          tr('appName'),
          color: AppColors.primaryColor,
        ),
      ],
      drawer: MainDrawer(
        scaffoldKey: scaffoldKey,
      ),
      child: notesVM.isLoading
          ? LoadingIndicators.instance.smallLoadingAnimation(context)
          : notesVM.notesList.isEmpty
              ? CustomText.h4(
                  context,
                  tr('thereAreNoVisualNotes'),
                  color: AppColors.grey,
                  alignment: Alignment.center,
                )
              : Column(
                  children: [
                    if (notesVM.selectedNotesIds.isNotEmpty)
                      MultiSelectionHeaderComponent(
                        notesVM: notesVM,
                      ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: Sizes.screenVPaddingDefault,
                          horizontal: Sizes.screenHPaddingDefault,
                        ),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(notesVM.notesList[index].noteId),
                            direction: notesVM.selectedNotesIds.isNotEmpty
                                ? DismissDirection.none
                                : DismissDirection.horizontal,
                            onDismissed: (direction) {
                              notesVM.deleteNote(
                                visualNoteModel: notesVM.notesList[index],
                              );
                            },
                            background: const NoteDismissBackgroundComponent(),
                            child: GestureDetector(
                              onTap: notesVM.selectedNotesIds.isNotEmpty
                                  ? () {
                                      notesVM.toggleNoteSelection(
                                        noteId: notesVM.notesList[index].noteId,
                                      );
                                    }
                                  : null,
                              onLongPress: () {
                                notesVM.toggleNoteSelection(
                                  noteId: notesVM.notesList[index].noteId,
                                );
                              },
                              child: NoteListItemComponent(
                                visualNoteModel: notesVM.notesList[index],
                                isSelectedNote: notesVM.isSelectedNote(
                                  noteId: notesVM.notesList[index].noteId,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: Sizes.vMarginMedium,
                        ),
                        itemCount: notesVM.notesList.length,
                      ),
                    ),
                  ],
                ),
    );
  }
}
