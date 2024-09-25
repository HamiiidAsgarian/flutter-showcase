// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_showcase/core/constants/app_colors.dart';

class AppColorTheme {
  AppColorTheme._();

  static CustomColors lightColorTheme = CustomColors(
    primary500: AppColors.primary500,
    secondary500: AppColors.secondary500,
    dark500: AppColors.dark500,
    light500: AppColors.light500,
    grey500: AppColors.grey500,
    backgroundWhite: AppColors.backgroundWhite,
    backgroundGrey: AppColors.backgroundGrey,
    greyMain: AppColors.greyMain,
    mainRed: AppColors.mainRed,
  );
  //----
  static CustomColors darkColorTheme =
      lightColorTheme.copyWith(secondary500: AppColors.secondary500);
}

class CustomColors {
  CustomColors({
    required this.primary500,
    required this.secondary500,
    required this.dark500,
    required this.light500,
    required this.grey500,
    required this.greyMain,
    required this.backgroundWhite,
    required this.backgroundGrey,
    required this.mainRed,
  });

  final Color primary500;
  final Color secondary500;
  final Color dark500;
  final Color light500;
  final Color grey500;
  final Color greyMain;
  final Color backgroundWhite;
  final Color backgroundGrey;
  final Color mainRed;

  // ignore: prefer_constructors_over_static_methods
  static CustomColors lerp(
    CustomColors? a,
    CustomColors? b,
    double t,
  ) {
    if (a == null) return b!;
    if (b == null) return a;

    return CustomColors(
      primary500: Color.lerp(a.primary500, b.primary500, t)!,
      secondary500: Color.lerp(a.secondary500, b.secondary500, t)!,
      dark500: Color.lerp(a.dark500, b.dark500, t)!,
      light500: Color.lerp(a.light500, b.light500, t)!,
      grey500: Color.lerp(a.grey500, b.grey500, t)!,
      greyMain: Color.lerp(a.greyMain, b.greyMain, t)!,
      backgroundWhite: Color.lerp(a.backgroundWhite, b.backgroundWhite, t)!,
      backgroundGrey: Color.lerp(a.backgroundGrey, b.backgroundGrey, t)!,
      mainRed: Color.lerp(a.mainRed, b.mainRed, t)!,
    );
  }

  CustomColors copyWith({
    Color? primary500,
    Color? secondary500,
    Color? dark500,
    Color? light500,
    Color? grey500,
    Color? greyMain,
    Color? backgroundWhite,
    Color? backgroundGrey,
    Color? mainRed,
  }) {
    return CustomColors(
      primary500: primary500 ?? this.primary500,
      secondary500: secondary500 ?? this.secondary500,
      dark500: dark500 ?? this.dark500,
      light500: light500 ?? this.light500,
      grey500: grey500 ?? this.grey500,
      greyMain: greyMain ?? this.greyMain,
      backgroundWhite: backgroundWhite ?? this.backgroundWhite,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      mainRed: mainRed ?? this.mainRed,
    );
  }
}
