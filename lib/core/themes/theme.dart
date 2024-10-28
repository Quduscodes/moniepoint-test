import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moniepoint/core/themes/colors.dart';
import 'package:moniepoint/core/themes/text_theme.dart';

class CustomTheme {
  static ThemeData getLightThemeData(BuildContext context) {
    return _lightThemeData(context);
  }

  static ThemeData getDarkThemeData(BuildContext context) {
    return _darkThemeData(context);
  }

  static ThemeData _lightThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'Euclid Circular A',
      textTheme: AppTextTheme.darkTextTheme,
      popupMenuTheme: PopupMenuThemeData(
        color: ColorConst.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
      ),
    );
  }

  static ThemeData _darkThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'Euclid Circular A',
      textTheme: AppTextTheme.darkTextTheme,
    );
  }
}
