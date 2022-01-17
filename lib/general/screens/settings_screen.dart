import 'package:flutter/material.dart';
import 'package:visual_notes/core/components/appbar_with_icon_component.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/screens/popup_page.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/general/components/settings_components/app_settings_section_component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      appBarWithBack: true,
      appbarItems: [
        AppBarWithIconComponent(
          icon: AppImages.settingsScreenIcon,
          title: tr('settings'),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault,
            horizontal: Sizes.screenHPaddingDefault,
          ),
          child: Column(
            children: const <Widget>[
              AppSettingsSectionComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
