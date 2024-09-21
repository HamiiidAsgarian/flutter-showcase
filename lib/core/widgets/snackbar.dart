import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class AppSnackbar {
  static Future<void> showError({
    required String message,
    required BuildContext context,
  }) async {
    await ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: context.colorz.mainRed,
            content: Text(message),
          ),
        )
        .closed;
  }

  //----
  static Future<void> showSuccess({
    required String message,
    required BuildContext context,
  }) async {
    await ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: context.colorz.secondary500,
            content: Text(message),
          ),
        )
        .closed;
  }
}
