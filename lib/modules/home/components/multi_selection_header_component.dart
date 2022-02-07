import 'package:flutter/material.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/number_parser.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/font_styles.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/modules/home/viewmodels/notes_viewmodel.dart';

class MultiSelectionHeaderComponent extends StatelessWidget {
  final NotesViewModel notesVM;

  const MultiSelectionHeaderComponent({
    required this.notesVM,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.hPaddingHighest,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              notesVM.clearNoteSelection();
            },
            icon: const Icon(
              Icons.close,
            ),
            iconSize: Sizes.iconsSizes['s4'],
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: Sizes.iconsSizes['s5'],
            key: const Key('clearSelectedItems'),
          ),
          SizedBox(
            width: Sizes.hMarginSmall,
          ),
          CustomText.h2(
            context,
            AppLocalizations.instance.isAr()
                ? NumberParser.instance.convertToArabicNumbers(
                    input: notesVM.selectedNotesIds.length.toString(),
                  )
                : notesVM.selectedNotesIds.length.toString(),
            weight: FontStyles.fontWeightMedium,
            overflow: TextOverflow.ellipsis,
            key: const Key('selectedItems'),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              notesVM.deleteSelectedNotes();
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.secondaryColor,
            ),
            iconSize: Sizes.iconsSizes['s4'],
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: Sizes.iconsSizes['s5'],
            key: const Key('deleteItemsButton'),
          ),
        ],
      ),
    );
  }
}
