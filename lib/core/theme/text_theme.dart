// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_text_styles.dart';

class AppTextTheme {
  AppTextTheme._();

  static CustomTextTheme lightTextTheme = CustomTextTheme(
    h1: AppTextStyles.h1,
    h2: AppTextStyles.h2,
    b1: AppTextStyles.b1,
  );
  //----
// text styles for the darkTextTheme is the same as the lightTextTheme(for now)
  static CustomTextTheme darkTextTheme = lightTextTheme;
}

class CustomTextTheme {
  CustomTextTheme({required this.h1, required this.h2, required this.b1});

  final TextStyle h1;
  final TextStyle h2;

  final TextStyle b1;
  // ignore: prefer_constructors_over_static_methods
  static CustomTextTheme lerp(
    CustomTextTheme? a,
    CustomTextTheme? b,
    double t,
  ) {
    if (a == null) return b!;
    if (b == null) return a;

    return CustomTextTheme(
      h1: TextStyle.lerp(a.h1, b.h1, t)!,
      h2: TextStyle.lerp(a.h2, b.h2, t)!,

      b1: TextStyle.lerp(a.b1, b.b1, t)!,
      // ... lerp other text style properties
    );
  }
}
