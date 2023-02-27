import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visual_notes/core/localization/all_translation_keys.dart';
import 'package:visual_notes/core/services/init_services/services_initializer.dart';
import 'package:visual_notes/core/services/navigation_service.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/app_themes.dart';
import 'package:visual_notes/core/utils/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List results = await ServiceInitializer.instance.initializeSettings();
  runApp(
    ProviderScope(
      child: MyApp(
        locale: results[0],
        theme: results[1],
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.locale,
    required this.theme,
    Key? key,
  }) : super(key: key);

  final Locale locale;
  final ThemeMode theme;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(414, 895)
              : const Size(895, 414),
          minTextAdapt: true,
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // For both Android + iOS
              statusBarColor: Colors.transparent,
              // For apps with a light background:
              // For Android (dark icons)
              statusBarIconBrightness: Brightness.dark,
              // For iOS (dark icons)
              statusBarBrightness: Brightness.light,
            ),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: GetMaterialApp(
                navigatorKey: NavigationService.navigationKey,
                builder: (context, widget) {
                  ScreenUtil.init(context);
                  return widget!;
                },
                debugShowCheckedModeBanner: false,
                title: 'Visual Notes',
                color: AppColors.primaryColor,
                translations: LanguageTranslation(),
                locale: locale,
                fallbackLocale: const Locale('en'),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                themeMode: theme,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                initialRoute: RoutePaths.coreSplash,
                onGenerateRoute: AppRouter.generateRoute,
              ),
            ),
          ),
        );
      },
    );
  }
}
