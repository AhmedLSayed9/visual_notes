import 'package:flutter/services.dart';
import 'package:visual_notes/core/localization/app_localization.dart';
import 'package:visual_notes/core/services/init_services/theme_service.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceInitializer {
  ServiceInitializer._();

  static final ServiceInitializer instance = ServiceInitializer._();

  initializeSettings() async {
    //This method is used to initialize any service before the app runs (in main method)
    List futures = [
      initializeLocalization(),
      initializeTheme(),
      //initializeScreensOrientation(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  initializeLocalization() async {
    return await AppLocalizations.instance.getUserStoredLocale();
  }

  initializeTheme() async {
    return await ThemeService.instance.getUserStoredTheme();
  }

  initializeScreensOrientation() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  }

  Future initializeData() async {
    List futures = [
      cacheDefaultImages(),
    ];
    List<dynamic> result = await Future.wait<dynamic>([...futures]);
    return result;
  }

  cacheDefaultImages() async {
    precacheImage(const AssetImage(AppImages.appLogoIcon), Get.context!);
    precacheImage(const AssetImage(AppImages.splash), Get.context!);
  }
}
