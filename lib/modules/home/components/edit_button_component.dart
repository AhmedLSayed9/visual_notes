import 'package:flutter/material.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/navigation_service.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/utils/routes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/core/widgets/custom_text_button.dart';
import 'package:visual_notes/modules/home/models/visual_note_model.dart';

class EditButtonComponent extends StatelessWidget {
  final VisualNoteModel visualNoteModel;

  const EditButtonComponent({
    required this.visualNoteModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      child: CustomText.h5(
        context,
        tr('edit'),
        color: AppColors.white,
        alignment: Alignment.center,
      ),
      elevation: 1,
      minWidth: Sizes.textButtonMinWidth,
      minHeight: Sizes.textButtonMinHeight,
      buttonColor: AppColors.secondaryColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          isNamed: true,
          page: RoutePaths.addEditNote,
          arguments: {'visualNoteModel': visualNoteModel},
        );
      },
    );
  }
}
