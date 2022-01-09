import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:visual_notes/core/components/appbar_with_icon_component.dart';
import 'package:visual_notes/core/screens/popup_page.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';
import 'package:visual_notes/general/model/language_model.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:visual_notes/general/viewmodel/settings_viewmodel.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingsVM = ref.watch(settingsViewModel);

    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.languageScreenIcon,
          title: tr('language'),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault,
            horizontal: Sizes.screenHPaddingDefault,
          ),
          child: Column(
            children: <Widget>[
              CustomText.h3(
                context,
                tr('selectYourPreferredLanguage'),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Sizes.vMarginMedium,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: languagesList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Sizes.vMarginSmall,
                  );
                },
                itemBuilder: (context, index) {
                  final _language = languagesList[index];
                  return InkWell(
                    onTap: () async {
                      settingsVM.changeLocale(
                        langCode: languagesList[index].code,
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
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1),
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
                                backgroundImage: AssetImage(_language.flag),
                                radius: Sizes.iconsSizes['s6'],
                              ),
                              if (settingsVM.selectedLanguageCode ==
                                  languagesList[index].code)
                                CircleAvatar(
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
                                ),
                            ],
                          ),
                          SizedBox(
                            width: Sizes.hMarginSmall,
                          ),
                          Expanded(
                            child: CustomText.h4(
                              context,
                              tr(_language.name),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
