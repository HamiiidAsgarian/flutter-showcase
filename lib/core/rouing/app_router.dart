import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen_bloc.dart';
import 'package:flutter_showcase/features/auth/presentation/signup_screen.dart';
import 'package:flutter_showcase/features/auth/presentation/signup_screen_bloc.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes { onBoarding, login, singup }

class AppRouter {
  static GoRouter getRoutes() {
    return GoRouter(
      initialLocation: '/login',
      routes: <RouteBase>[
        GoRoute(
          path: '/onboarding',
          name: Routes.onBoarding.name,
          builder: (context, state) => BlocProvider(
            create: (context) => OnBoardingBloc(),
            child: const OnBoardingScreen(),
          ),
        ),
        GoRoute(
          path: '/login',
          name: Routes.login.name,
          builder: (context, state) => BlocProvider(
            create: (context) => LoginScreeBloc(),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: Routes.singup.name,
          builder: (context, state) => BlocProvider(
            create: (context) => SignUpScreeBloc(),
            child: const SignUpScreen(),
          ),
        ),
      ],
    );
  }
}
