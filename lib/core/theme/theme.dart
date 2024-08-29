import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';
import 'package:flutter_showcase/core/theme/color_theme.dart';
import 'package:flutter_showcase/core/theme/text_theme.dart';
import 'package:flutter_showcase/gen/fonts.gen.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightThemeData = ThemeData(
    //For custom tailored theming
    extensions: <ThemeExtension<AppThemeExtension>>[
      AppThemeExtension(
        customColors: AppColorTheme.lightColorTheme,
        customTextTheme: AppTextTheme.lightTextTheme,
      ),
    ],

    useMaterial3: true,
    fontFamily: FontFamily.avenir,
    brightness: Brightness.light,
    primaryColor: AppColors.primary500,
  );
//----
  static ThemeData darkThemeData = ThemeData(
    //For custom tailored theming
    extensions: <ThemeExtension<AppThemeExtension>>[
      AppThemeExtension(
        customColors: AppColorTheme.darkColorTheme,
        customTextTheme: AppTextTheme.darkTextTheme,
      ),
    ],
    useMaterial3: true,
    fontFamily: FontFamily.avenir,
    brightness: Brightness.light,
    primaryColor: AppColors.green1,
  );
}
