import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/general/model/language_model.dart';
import 'package:visual_notes/general/viewmodel/settings_viewmodel.dart';

class LanguageItemComponent extends ConsumerWidget {
  const LanguageItemComponent({
    required this.languageModel,
    Key? key,
  }) : super(key: key);

  final LanguageModel languageModel;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () async {
        ref.read(settingsViewModel).changeLocale(
              langCode: languageModel.code,
            );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.vPaddingSmallest,
          horizontal: Sizes.hPaddingMedium,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(languageModel.flag),
                  radius: Sizes.iconsSizes['s6'],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final _settingsVM = ref.watch(settingsViewModel);
                    return (_settingsVM.selectedLanguageCode ==
                            languageModel.code)
                        ? CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.8),
                            radius: Sizes.iconsSizes['s6'],
                            child: Icon(
                              Icons.check,
                              size: Sizes.iconsSizes['s5'],
                              color: context.theme.primaryColor,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
            SizedBox(
              width: Sizes.hMarginSmall,
            ),
            Expanded(
              child: CustomText.h4(
                context,
                tr(languageModel.name),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
