import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/themes/theme.dart';
import 'package:moniepoint/features/bottom_appbar/presentation/presentation/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: SchedulerBinding
                        .instance.platformDispatcher.platformBrightness ==
                    Brightness.dark
                ? CustomTheme.getDarkThemeData(context)
                : CustomTheme.getLightThemeData(context),
            home: const CustomBottomAppbarView(),
          );
        });
  }
}
