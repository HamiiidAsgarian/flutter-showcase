import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/di/get_it.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen.dart';
import 'package:flutter_showcase/features/auth/presentation/login_screen_bloc.dart';
import 'package:flutter_showcase/features/auth/presentation/signup_screen.dart';
import 'package:flutter_showcase/features/auth/presentation/signup_screen_bloc.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

/// Contains the main app routing.
///
/// * [Routes], the enum for the different routes.
enum Routes { onBoarding, login, singup }

/// * [GoRouter], the class from the go_router package that handles the routing.
class AppRouter {
  /// The different routes of the app.

  /// Returns the [GoRouter] that handles the app's routing.
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
            create: (context) => LoginScreeBloc(
              authRepository: getIt<IAuthRepository>(),
            ),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: Routes.singup.name,
          builder: (context, state) => BlocProvider(
            create: (context) => SignUpScreeBloc(
              authRepository: getIt<IAuthRepository>(),
            ),
            child: const SignUpScreen(),
          ),
        ),
      ],
    );
  }
}
