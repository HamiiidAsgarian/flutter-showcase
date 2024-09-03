import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('data'),
          CupertinoButton(
            child: const Text('data'),
            onPressed: () {
              context.goNamed(Routes.onBoarding.name);
            },
          ),
        ],
      ),
    );
  }
}
