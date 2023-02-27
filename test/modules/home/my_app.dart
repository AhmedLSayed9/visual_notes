import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visual_notes/core/utils/routes.dart';
import 'package:visual_notes/modules/home/screens/visual_notes_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(414, 895)
              : const Size(895, 414),
          minTextAdapt: true,
          builder: (context, child) {
            return GetMaterialApp(
              builder: (context, widget) {
                ScreenUtil.init(context);
                return widget!;
              },
              home: VisualNotesScreen(),
              onGenerateRoute: AppRouter.generateRoute,
            );
          });
    });
  }
}
