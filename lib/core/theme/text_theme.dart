import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    titleLarge: const TextStyle().copyWith(
      fontSize: 21,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    ),
  );
}
