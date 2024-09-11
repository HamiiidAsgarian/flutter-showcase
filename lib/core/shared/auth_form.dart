import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/constants/app_sizes.dart';
import 'package:flutter_showcase/core/theme/app_theme_extension.dart';
import 'package:flutter_showcase/core/utils/util_extensions.dart';
import 'package:flutter_showcase/features/auth/presentation/widgets/check_box_texted.dart';
import 'package:flutter_showcase/features/auth/presentation/widgets/login_option_box.dart';
import 'package:flutter_showcase/features/auth/presentation/widgets/my_main_button.dart';
import 'package:flutter_showcase/features/auth/presentation/widgets/or_divider.dart';
import 'package:flutter_showcase/features/auth/presentation/widgets/text_from_field.dart';
import 'package:flutter_showcase/l10n/ln10.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    required this.onChangedCheckbox,
    required this.onPressedButton,
    required this.onPressedFooterButton,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.title,
    required this.footerButtonText,
    required this.footerText,
    required this.buttonText,
    this.defaultEmailText,
    this.defaultPasswordText,
    super.key,
  });

  final String? Function(String?)? onEmailSaved;
  final String? Function(String?)? onPasswordSaved;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool value) onChangedCheckbox;
  final void Function() onPressedButton;
  final void Function() onPressedFooterButton;
  final String title;
  final String buttonText;
  final String footerButtonText;
  final String footerText;

  final String? defaultEmailText;
  final String? defaultPasswordText;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    if (widget.defaultEmailText != null) {
      _emailController = TextEditingController();
      _emailController!.text = widget.defaultEmailText!;
    }
    if (widget.defaultPasswordText != null) {
      _passwordController = TextEditingController();
      _passwordController!.text = widget.defaultPasswordText!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: context.colors.backgroundWhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeR.r16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: context.styles.h1),
              SizedBox(
                height: 50.r,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    PrefixedSuffixedTextFromField(
                      controller: _emailController,
                      onFieldSubmitted: (_) {
                        _passwordFocusNode.requestFocus();
                        return null;
                      },
                      autofocus: true,
                      // focusNode: _emailFocusNode,
                      validator: (text) {
                        if (text!.isValidEmail == false) {
                          return context.l10n.emailIsIncorrect;
                        } else {
                          return null;
                        }
                      },
                      onSaved: widget.onEmailSaved,

                      hintText: context.l10n.email,
                      prefixIcon: const Icon(Icons.email),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: SizeR.r12,
                    ),
                    PrefixedSuffixedTextFromField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      isObsecured: true,
                      validator: (text) {
                        return (text ?? '').passwordCheck(context);
                      },
                      onSaved: widget.onPasswordSaved,
                      hintText: context.l10n.password,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility_off),
                      suffixIconAlternative: const Icon(Icons.visibility),
                      keyboardType: TextInputType.visiblePassword,
                      onPressedSuffixIcon: () {},
                    ),
                    SizedBox(
                      height: SizeR.r12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CheckboxTexed(
                          onChanged: widget.onChangedCheckbox,
                        ),
                        Text(
                          context.l10n.rememberMe,
                          style: context.styles.b1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeR.r12,
                    ),
                    MyMainButton(
                      text: widget.buttonText,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.onPressedButton();
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeR.r16,
                    ),
                    SizedBox(
                      height: 50.r,
                    ),
                    const ORdivider(),
                    SizedBox(
                      height: 32.r,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginOption.facebook(),
                        LoginOption.google(),
                        LoginOption.appke(),
                      ],
                    ),
                    SizedBox(
                      height: 32.r,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.footerText,
                          style: context.styles.b1
                              .copyWith(color: context.colors.greyMain),
                        ),
                        TextButton(
                          onPressed: widget.onPressedFooterButton,
                          child: Text(
                            widget.footerButtonText,
                            style: context.styles.b1.copyWith(
                              color: context.colors.primary500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
