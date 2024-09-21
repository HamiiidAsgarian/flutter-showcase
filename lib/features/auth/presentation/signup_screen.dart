import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:flutter_showcase/core/shared/auth_form.dart';
import 'package:flutter_showcase/core/widgets/snackbar.dart';
import 'package:flutter_showcase/features/auth/presentation/signup_screen_bloc.dart';
import 'package:flutter_showcase/l10n/ln10.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    context.read<SignUpScreeBloc>().add(GetUserDataFromLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpScreeBloc, SignUpScreeState>(
      buildWhen: (previous, current) =>
          previous.rememberMe != current.rememberMe,
      listenWhen: (previous, current) => previous.stage != current.stage,
      listener: (context, state) {
        if (state.stage == Stage.success) {
          _showSnackbar().then((_) {
            if (mounted) {
              // ignore: use_build_context_synchronously
              context.goNamed(Routes.login.name);
            }
          });
        }
      },
      builder: (context, state) {
        return AuthForm(
          key: UniqueKey(),
          rememberMeDefault: state.rememberMe,
          footerText: context.l10n.dontHaveAnAccount,
          buttonText: context.l10n.signup,
          title: context.l10n.signup,
          footerButtonText: context.l10n.login,
          onPressedFooterButton: () {
            context.replaceNamed(Routes.login.name);
          },
          onChangedCheckbox: (newVal) {
            context
                .read<SignUpScreeBloc>()
                .add(ChangeRememberMe(checkboxValue: newVal));
          },
          onPressedButton: () {
            context.read<SignUpScreeBloc>().add(ValidateForm());
          },
          onEmailSaved: (savedText) {
            context.read<SignUpScreeBloc>().add(SaveEmail(savedText ?? ''));
            return null;
          },
          onPasswordSaved: (savedText) {
            context.read<SignUpScreeBloc>().add(SavePassword2(savedText ?? ''));
            return null;
          },
        );
      },
    );
  }

  Future<void> _showSnackbar() async {
    await AppSnackbar.showSuccess(
      context: context,
      message: 'success!',
    );
  }
}
