import 'package:flutter/material.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/sizes.dart';

class NoteDismissBackgroundComponent extends StatelessWidget {
  const NoteDismissBackgroundComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.hPaddingMedium,
      ),
      child: Icon(
        Icons.delete,
        size: Sizes.iconsSizes['s2'],
        color: AppColors.white,
      ),
    );
  }
}
