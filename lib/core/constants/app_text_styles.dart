import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/constants/app_colors.dart';
import 'package:flutter_showcase/core/constants/assets.dart';

//Dont use this directly inside UI as possible, use [TextStyleAdaptor] to make
//the UI theme aware
final class AppTextStyles {
  AppTextStyles._();

  static const _fontFamily = Assets.avenir;
  static const _letterSpacing = -0.02;

  ///--------------------------- Headings ---------------------------
  /// previously kHeaderExtraLarge
  static final h1 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.mainBlack,
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
    height: 40 / 32,
  );

  static final h2 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.mainBlack,
    fontWeight: FontWeight.bold,
    fontSize: 22.sp,
    height: 28 / 22,
  );

  static final h3 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.mainBlack,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    height: 24 / 18,
  );

  static final h4 = TextStyle(
    fontFamily: _fontFamily,
    letterSpacing: _letterSpacing,
    color: AppColors.mainBlack,
    fontWeight: FontWeight.w600,
    fontSize: 15.sp,
    height: 24 / 15,
  );
}
