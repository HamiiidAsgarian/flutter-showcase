import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';
import 'package:flutter_showcase/core/theme/color_theme.dart';
import 'package:flutter_showcase/core/theme/text_theme.dart';
import 'package:flutter_showcase/gen/fonts.gen.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightThemeData = ThemeData(
    //-----------------------Custom Design values-----------------------------
    extensions: <ThemeExtension<AppThemeExtension>>[
      AppThemeExtension(
        customColors: AppColorTheme.lightColorTheme,
        customTextTheme: AppTextTheme.lightTextTheme,
      ),
    ],
    //-----------------------Divider-----------------------------
    dividerTheme:
        DividerThemeData(color: AppColors.backgroundGrey, thickness: 2.r),
    //-----------------------Theme-----------------------------
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
          // Fill color for checked state
        }
        return null; // No fill color for unchecked state
      }),
      checkColor: WidgetStateProperty.all(
        AppColors.backgroundWhite,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      side: BorderSide(
        width: 2.r,
        color: AppColors.primary500,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.primary500,
      ),
    ),
    //-----------------------Theme-----------------------------

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundGrey,
      prefixIconColor: AppColors.greyMain,
      suffixIconColor: AppColors.greyMain,
      hintStyle: const TextStyle(color: AppColors.greyMain),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          SizeR.r12,
        ),
        borderSide: BorderSide.none,
      ),
      // labelStyle: const TextStyle(
      //   color: Color.fromARGB(162, 28, 28, 28),
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeR.r12),
        borderSide: const BorderSide(
          color: AppColors.primary500,
          width: 2,
        ),
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(SizeR.r12),
      //   borderSide: const BorderSide(color: Colors.red, width: 5),
      // ),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(SizeR.r12),
      //   borderSide: const BorderSide(color: Colors.red, width: 5),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(SizeR.r12),
      //   borderSide: const BorderSide(color: Colors.red, width: 5),
      // ),
    ),
    //For custom tailored theming

    useMaterial3: true,
    fontFamily: FontFamily.avenir,
    brightness: Brightness.light,
  );
//----
  static ThemeData darkThemeData = lightThemeData.copyWith(
    //For custom tailored theming
    extensions: <ThemeExtension<AppThemeExtension>>[
      AppThemeExtension(
        customColors: AppColorTheme.darkColorTheme,
        customTextTheme: AppTextTheme.darkTextTheme,
      ),
    ],
    brightness: Brightness.dark,
  );
}
