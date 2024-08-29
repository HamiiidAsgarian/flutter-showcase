import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';

class AppColorTheme {
  AppColorTheme._();

  static CustomColors lightColorTheme = CustomColors(
    primary1: AppColors.primary500,
    secondary1: AppColors.mainBlack,
  );
  //----
  static CustomColors darkColorTheme = CustomColors(
    primary1: AppColors.mainBlack,
    secondary1: AppColors.primary500,
  );
}

class CustomColors {
  CustomColors({
    required this.primary1,
    required this.secondary1,
  });

  final Color primary1;
  final Color secondary1;

  // ignore: public_member_api_docs, prefer_constructors_over_static_methods
  static CustomColors lerp(
    CustomColors? a,
    CustomColors? b,
    double t,
  ) {
    if (a == null) return b!;
    if (b == null) return a;

    return CustomColors(
      primary1: Color.lerp(a.primary1, b.primary1, t)!,
      secondary1: Color.lerp(a.secondary1, b.secondary1, t)!,
    );
  }
}
