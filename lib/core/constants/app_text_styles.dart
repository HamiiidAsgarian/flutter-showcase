import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';
import 'package:flutter_showcase/gen/fonts.gen.dart';

//Dont use this directly inside UI as possible, use [TextStyleAdaptor] to make
//the UI theme aware
final class AppTextStyles {
  AppTextStyles._();

  static const _fontFamily = FontFamily.avenir;
  static const _letterSpacing = -0.2;

  ///--------------------------- Headings ---------------------------
  /// previously kHeaderExtraLarge
  ///
  static final h1 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.dark500,
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
    height: 40 / 32,
  );

  static final h2 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.dark500,
    fontWeight: FontWeight.bold,
    fontSize: 26.sp,
    height: 40 / 32,
  );

  static final b1 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.dark500,
    fontWeight: FontWeight.w600,
    fontSize: 15.sp,
    height: 24 / 15,
  );
}
