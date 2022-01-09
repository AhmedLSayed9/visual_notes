import 'package:flutter/material.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/date_parser.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/font_styles.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_button.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/modules/add_edit_note/viewmodels/add_note_viewmodel.dart';

class NoteDateComponent extends StatelessWidget {
  const NoteDateComponent({
    required this.addNoteVM,
    Key? key,
  }) : super(key: key);

  final AddNoteViewModel addNoteVM;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: Sizes.roundedButtonMediumWidth,
      buttonColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Sizes.roundedButtonSmallRadius,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.hPaddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomText.h5(
              context,
              addNoteVM.noteDate == null
                  ? tr('tapToSelectDate')
                  : DateParser.instance.convertUTCToLocal(addNoteVM.noteDate!),
              color: AppColors.white,
              weight: FontStyles.fontWeightMedium,
              alignment: Alignment.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: Sizes.hMarginSmallest,
          ),
          Icon(
            Icons.date_range,
            size: Sizes.iconsSizes['s5'],
            color: AppColors.white,
          ),
        ],
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        addNoteVM.pickNoteDate(context: context);
      },
    );
  }
}
