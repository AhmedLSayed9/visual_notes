import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_notes/core/components/check_box_component.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/modules/add_edit_note/viewmodels/add_note_viewmodel.dart';
import 'package:visual_notes/modules/home/utils/enums.dart';

class NoteStatusComponent extends StatelessWidget {
  const NoteStatusComponent({
    required this.addNoteVM,
    Key? key,
  }) : super(key: key);

  final AddNoteViewModel addNoteVM;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText.h4(
          context,
          tr('noteStatus'),
          color: context.textTheme.headline5!.color,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: Sizes.hPaddingTiny),
        ),
        SizedBox(
          width: Sizes.hMarginSmall,
        ),
        Expanded(
          child: CheckBoxComponent(
            values: NoteStatus.values.map((e) => e.name).toList(),
            selectedValue: addNoteVM.noteStatus,
            onSelected: addNoteVM.pickNoteStatus,
          ),
        ),
      ],
    );
  }
}
