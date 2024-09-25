import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:flutter_showcase/core/shared/auth_form.dart';
import 'package:flutter_showcase/core/widgets/snackbar.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen_bloc.dart';
import 'package:flutter_showcase/l10n/ln10.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    context.read<LoginScreeBloc>().add(GetUserDataFromLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreeBloc, LoginScreeState>(
      listenWhen: (previous, current) => previous.stage != current.stage,
      listener: (context, state) {
        if (state.stage == Stage.success) {
          AppSnackbar.showSuccess(
            context: context,
            message: context.l10n.successMessage,
          ).then((_) {
            if (mounted) {
              // ignore: use_build_context_synchronously
              context.goNamed(Routes.home.name);
            }
          });
        }
        if (state.stage == Stage.error) {
          AppSnackbar.showError(
            context: context,
            message: context.l10n.failMessage,
          );
        }
      },
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return AuthForm(
          key: UniqueKey(),
          rememberMeDefault: state.rememberMe,
          defaultEmailText: state.user?.email,
          defaultPasswordText: state.user?.password,
          footerText: context.l10n.dontHaveAnAccount,
          buttonText: context.l10n.login,
          title: context.l10n.logIntoYourAccount,
          footerButtonText: context.l10n.signup,
          onPressedFooterButton: () {
            context.replaceNamed(Routes.singup.name);
          },
          onChangedCheckbox: (newVal) {
            context
                .read<LoginScreeBloc>()
                .add(ChangeRememberMe(checkboxValue: newVal));
          },
          onPressedButton: () {
            context.read<LoginScreeBloc>().add(ValidateForm());
          },
          onEmailSaved: (savedText) {
            context.read<LoginScreeBloc>().add(SaveEmail(savedText ?? ''));
            return null;
          },
          onPasswordSaved: (savedText) {
            context.read<LoginScreeBloc>().add(SavePassword(savedText ?? ''));
            return null;
          },
        );
      },
    );
  }
}
