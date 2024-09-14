import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:flutter_showcase/features/splash/presentation/spash_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashBloc>().add(LoadUserStorage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.stage == SplashStage.validToken) {
          context.replaceNamed(Routes.home.name);
        } else if (state.stage == SplashStage.noToken) {
          context.replaceNamed(Routes.onBoarding.name);
        } else if (state.stage == SplashStage.invalidToken) {
          context.replaceNamed(Routes.login.name);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<SplashBloc, SplashState>(
                builder: (context, state) {
                  return Text(state.stage.name);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SplashBloc>().add(RemoveLocals());
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
