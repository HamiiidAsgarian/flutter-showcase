import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/theme/color_theme.dart';
import 'package:flutter_showcase/core/theme/text_theme.dart';

///Custom ThemeExtension for matching custom design system(figma) and this App
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.customTextTheme,
    required this.customColors,
  });

  final CustomTextTheme customTextTheme;
  final CustomColors customColors;

  @override
  AppThemeExtension copyWith({
    CustomTextTheme? customTextTheme,
    CustomColors? customColors,
  }) {
    return AppThemeExtension(
      customTextTheme: customTextTheme ?? this.customTextTheme,
      customColors: customColors ?? this.customColors,
    );
  }

  @override
  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other == null) return this;

    final otherAppTheme = other as AppThemeExtension;

    final lerpedColors =
        CustomColors.lerp(customColors, otherAppTheme.customColors, t);
    final lerpedTextTheme =
        CustomTextTheme.lerp(customTextTheme, otherAppTheme.customTextTheme, t);

    return AppThemeExtension(
      customColors: lerpedColors,
      customTextTheme: lerpedTextTheme,
    );
  }
}

extension Xtheme on BuildContext {
  CustomColors get colorz =>
      Theme.of(this).extension<AppThemeExtension>()!.customColors;

  CustomTextTheme get styles =>
      Theme.of(this).extension<AppThemeExtension>()!.customTextTheme;

  ThemeData get themeData => Theme.of(this);
}
