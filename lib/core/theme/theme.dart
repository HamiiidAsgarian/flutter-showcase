import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';
import 'package:flutter_showcase/core/theme/text_theme.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    //fontFamily: 'Popins',
    brightness: Brightness.light,
    primaryColor: AppColors.primary500,

    textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    //fontFamily: 'Popins',
    brightness: Brightness.dark,
    primaryColor: AppColors.primary500,
    textTheme: AppTextTheme.darkTextTheme,
  );
}
