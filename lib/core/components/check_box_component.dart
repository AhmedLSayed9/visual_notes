import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  final List<String> values;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const CheckBoxComponent({
    required this.values,
    this.selectedValue,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Sizes.checkBoxSpacing,
      direction: Axis.horizontal,
      children: List.generate(
        values.length,
        (index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: selectedValue == values[index],
                onChanged: (value) {
                  onSelected(values[index]);
                },
                activeColor: AppColors.primaryColor,
                splashRadius: Sizes.checkBoxSplashRadius,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              CustomText.h4(
                context,
                tr(values[index]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
