import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';

class PrefixedSuffixedTextFromField extends StatefulWidget {
  const PrefixedSuffixedTextFromField({
    required this.prefixIcon,
    this.suffixIcon,
    this.onPressedSuffixIcon,
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
    this.suffixIconAlternative,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.isObsecured = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.autofocus = false,
  });

  final String? hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool isObsecured;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onFieldSubmitted;

  final FocusNode? focusNode;

  ///For when siffix icon should change after pressing
  final Widget? suffixIconAlternative;
  final void Function()? onPressedSuffixIcon;
  final TextInputType? keyboardType;
  final bool autofocus;
  @override
  State<PrefixedSuffixedTextFromField> createState() =>
      _PrefixedSuffixedTextFromFieldState();
}

class _PrefixedSuffixedTextFromFieldState
    extends State<PrefixedSuffixedTextFromField> {
  Color? hintColor;
  Color? fillColor;
  late bool suffixIcontAltered; // is true by defauld(constructor)
  @override
  void initState() {
    suffixIcontAltered = widget.isObsecured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {});

        if (value) {
          hintColor = context.colorz.primary500;
          fillColor = context.colorz.primary500.withOpacity(.1);
        } else {
          hintColor = context.themeData.inputDecorationTheme.hintStyle!.color;
          fillColor = context.themeData.inputDecorationTheme.fillColor;
        }
      },
      child: TextFormField(
        autofocus: widget.autofocus,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        onSaved: widget.onSaved,
        validator: widget.validator,
        obscureText: suffixIcontAltered,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          fillColor: fillColor,
          suffixIcon: (widget.suffixIcon != null)
              ? IconButton(
                  onPressed: widget.onPressedSuffixIcon != null
                      ? () {
                          widget.onPressedSuffixIcon!();
                          setState(() {
                            suffixIcontAltered = !suffixIcontAltered;
                          });
                        }
                      : null,
                  icon: _suffixIcon(),
                )
              : null,
          suffixIconColor: hintColor,
          prefixIconColor: hintColor,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
        ),
      ),
    );
  }

  Widget _suffixIcon() {
    if (widget.suffixIconAlternative != null) {
      return suffixIcontAltered
          ? widget.suffixIcon!
          : widget.suffixIconAlternative!;
    }
    return widget.suffixIcon!;
  }
}

//----
class MyTextFromField extends StatefulWidget {
  const MyTextFromField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
  });

  final String? hintText;
  final bool? obscureText;
  final TextEditingController? controller;

  @override
  State<MyTextFromField> createState() => _MyTextFromFieldState();
}

class _MyTextFromFieldState extends State<MyTextFromField> {
  Color? hintColor;
  Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {});

        if (value) {
          hintColor = context.colorz.primary500;
          fillColor = context.colorz.primary500.withOpacity(.1);
        } else {
          hintColor = context.themeData.inputDecorationTheme.hintStyle!.color;
          fillColor = context.themeData.inputDecorationTheme.fillColor;
        }
      },
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: fillColor,
          suffixIconColor: hintColor,
          prefixIconColor: hintColor,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
