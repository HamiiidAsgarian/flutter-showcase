// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/constants/app_text_styles.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: AppTextStyles.h3,
    // titleMedium: AppTextStyles.h2,
    // titleSmall: AppTextStyles.h1,
  );

  static TextTheme darkTextTheme = TextTheme(headlineLarge: AppTextStyles.h3);
}
