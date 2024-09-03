import 'package:flutter/material.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  onBoarding,
  login,
}

class AppRouter {
  static GoRouter getRoutes() {
    return GoRouter(
      initialLocation: '/login',
      routes: <RouteBase>[
        GoRoute(
          path: '/onboarding',
          name: Routes.onBoarding.name,
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoardingScreen();
          },
        ),
        GoRoute(
          path: '/login',
          name: Routes.login.name,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
      ],
    );
  }
}
