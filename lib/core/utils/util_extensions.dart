import 'package:flutter/material.dart';
import 'package:flutter_showcase/l10n/ln10.dart';

extension XString on String {
  /// A string is a valid email if it has at least
  /// 1-letters (a-z or A-Z),
  /// 2-numbers (0-9),
  /// 3-one of special characters: . ! # $ % & ' * + - / = ? ^ _ ` { | } ~
  /// 4-@ character,
  /// 5-domain name,
  /// 6-extension (something like .com, .net, .io, ...).
  bool get isValidEmail => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(this);

  /// A string is a valid password if it has at least
  /// 1-one upper case letter,
  /// 2-at least one lower case letter,
  /// 3- at least one number,
  /// 4- and at least one special character.
  /// 5- The string must also be at least 8 characters long.
  // bool get isValidPassword => RegExp(
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  //     ).hasMatch(this);

  String? passwordCheck(BuildContext context) {
    if (length < 8) {
      return context.l10n.passwordRequirement1;
    }
    if (!RegExp('[A-Z]').hasMatch(this)) {
      return context.l10n.passwordRequirement2;
    }
    if (!RegExp('[a-z]').hasMatch(this)) {
      return context.l10n.passwordRequirement3;
    }
    if (!RegExp('[0-9]').hasMatch(this)) {
      return context.l10n.passwordRequirement4;
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(this)) {
      return context.l10n.passwordRequirement5;
    }
    return null;
  }
}
