import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///this act like a adaptor to customize figma design standards to flutter theme
class TextStyleAdapter {
  static TextStyle h1(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!;
  }

  static TextStyle h2(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  static TextStyle h3(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!;
  }

  static TextStyle h4(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 30.sp);
  }
}
