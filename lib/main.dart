import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visual_notes/core/localization/all_translation_keys.dart';
import 'package:visual_notes/core/services/init_services/services_initializer.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({
    required this.locale,
    required this.theme,
    Key? key,
  }) : super(key: key);

  final Locale locale;
  final ThemeMode theme;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final _currentOrientation = ScreenUtil().orientation;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (_currentOrientation != ScreenUtil().orientation) {
        Get.forceAppUpdate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(414, 895)
              : const Size(895, 414),
          minTextAdapt: true,
          builder: () => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              //For applications with a light background:
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Visual Notes',
                color: AppColors.primaryColor,
                translations: LanguageTranslation(),
                locale: widget.locale,
                fallbackLocale: const Locale('en'),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                themeMode: widget.theme,
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
