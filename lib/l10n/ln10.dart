import 'package:flutter/material.dart';
import 'package:flutter_showcase/l10n/arb/app_localizations.dart';

/// extension on BuildContext to get [AppLocalizations]
extension AppLocalizationsX on BuildContext {
  /// getter on BuildContext for AppLocalizations
  AppLocalizations get l10n => AppLocalizations.of(this);
}
