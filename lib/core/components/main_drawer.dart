import 'package:flutter/material.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/navigation_service.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/font_styles.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/core/utils/routes.dart';
import 'package:visual_notes/core/widgets/custom_image.dart';
import 'package:visual_notes/core/widgets/custom_text.dart';

class MainDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainDrawer({
    required this.scaffoldKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.mainDrawerWidth,
      child: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.mainDrawerVPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomImage.s1(
                    AppImages.appLogoIcon,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: Sizes.vMarginSmall,
                ),
                CustomText.h3(
                  context,
                  tr('appName'),
                  weight: FontStyles.fontWeightBlack,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.center,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: Sizes.vMarginHigh,
                ),
                DrawerItem(
                  title: tr('addNewNote'),
                  icon: AppImages.addNoteScreenIcon,
                  onTap: () {
                    scaffoldKey.currentState!.openEndDrawer();
                    NavigationService.navigateTo(
                      navigationMethod: NavigationMethod.push,
                      isNamed: true,
                      page: RoutePaths.addEditNote,
                      arguments: {'visualNoteModel': null},
                    );
                  },
                ),
                DrawerItem(
                  title: tr('settings'),
                  icon: AppImages.settingsScreenIcon,
                  onTap: () {
                    scaffoldKey.currentState!.openEndDrawer();
                    NavigationService.navigateTo(
                      navigationMethod: NavigationMethod.push,
                      isNamed: true,
                      page: RoutePaths.settings,
                    );
                  },
                ),
                SizedBox(
                  height: Sizes.vMarginMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageIcon(
        AssetImage(icon),
      ),
      title: CustomText.h4(
        context,
        title,
        weight: FontStyles.fontWeightMedium,
      ),
      onTap: onTap,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.symmetric(
        horizontal: Sizes.mainDrawerHPadding,
      ),
    );
  }
}
