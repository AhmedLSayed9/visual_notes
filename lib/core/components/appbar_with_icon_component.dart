import 'package:flutter/material.dart';
import 'package:visual_notes/core/styles/font_styles.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';

class AppBarWithIconComponent extends StatelessWidget {
  final String icon;
  final String title;

  const AppBarWithIconComponent({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(
            icon,
          ),
          size: Sizes.appBarIconSize,
        ),
        SizedBox(
          width: Sizes.hMarginComment,
        ),
        CustomText.h2(
          context,
          title,
          weight: FontStyles.fontWeightSemiBold,
        ),
      ],
    );
  }
}
