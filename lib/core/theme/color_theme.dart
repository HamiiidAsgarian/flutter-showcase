// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_showcase/core/constants/app_colors.dart';

class AppColorTheme {
  AppColorTheme._();

  static CustomColors lightColorTheme = CustomColors(
    primary1: AppColors.primary500,
    secondary1: AppColors.secondary500,
    dark: AppColors.dark500,
    light: AppColors.light500,
    grey500: AppColors.grey500,
  );
  //----
  static CustomColors darkColorTheme =
      lightColorTheme.copyWith(secondary1: AppColors.primary900);
}

class CustomColors {
  CustomColors({
    required this.primary1,
    required this.secondary1,
    required this.dark,
    required this.light,
    required this.grey500,
  });

  final Color primary1;
  final Color secondary1;
  final Color dark;
  final Color light;
  final Color grey500;

  // ignore: prefer_constructors_over_static_methods
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
      dark: Color.lerp(a.dark, b.dark, t)!,
      light: Color.lerp(a.light, b.light, t)!,
      grey500: Color.lerp(a.grey500, b.grey500, t)!,
    );
  }

  CustomColors copyWith({
    Color? primary1,
    Color? secondary1,
    Color? dark,
    Color? light,
    Color? grey500,
  }) {
    return CustomColors(
      primary1: primary1 ?? this.primary1,
      secondary1: secondary1 ?? this.secondary1,
      dark: dark ?? this.dark,
      light: light ?? this.light,
      grey500: grey500 ?? this.grey500,
    );
  }
}
