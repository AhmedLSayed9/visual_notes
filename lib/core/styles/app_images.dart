import 'dart:core';

class AppImages {
  static const String jsonPath = 'assets/json/';
  static const String welcomeImagesPath = 'assets/images/welcome/';
  static const String coreImagesPath = 'assets/images/core/';
  static const String dialogWidgetIconsPath =
      coreImagesPath + 'dialog_widget_icons/';
  static const String appIconsPath = 'assets/images/app_icons/';
  static const String appScreensIconsPath = appIconsPath + 'screens_icons/';
  static const String appLanguagesIconsPath = appIconsPath + 'languages_icons/';

  /// Splash Screen + OnBoarding
  static const String splash = welcomeImagesPath + 'splash.png';
  static const String splashAnimation = jsonPath + 'splash_animation.json';

  /// Core
  static const String appLogoIcon = coreImagesPath + 'icon.png';
  static const String cameraIcon = coreImagesPath + 'camera.png';
  static const String placeHolderImage = coreImagesPath + 'place_holder.png';
  static const String loadingIndicator = jsonPath + 'loading.json';
  //Dialog Widget Icons
  static const String location = dialogWidgetIconsPath + 'location.png';
  static const String ask = dialogWidgetIconsPath + 'ask.png';
  static const String confirmation = dialogWidgetIconsPath + 'confirmation.png';
  static const String error = dialogWidgetIconsPath + 'error.png';
  static const String info = dialogWidgetIconsPath + 'info.png';
  static const String infoReverse = dialogWidgetIconsPath + 'info_reverse.png';
  static const String noHeader = dialogWidgetIconsPath + 'no_header.png';
  static const String success = dialogWidgetIconsPath + 'success.png';
  static const String warning = dialogWidgetIconsPath + 'warning.png';

  /// App Icons
  //Screens Icons
  static const String settingsScreenIcon = appScreensIconsPath + 'settings.png';
  static const String languageScreenIcon = appScreensIconsPath + 'language.png';
  static const String addNoteScreenIcon = appScreensIconsPath + 'add_note.png';

  //Languages Icons
  static const String languageIconEnglish =
      appLanguagesIconsPath + 'english.png';
  static const String languageIconArabic = appLanguagesIconsPath + 'arabic.png';
}
