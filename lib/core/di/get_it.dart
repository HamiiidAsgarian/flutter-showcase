import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_showcase/app_config.dart';
import 'package:flutter_showcase/features/auth/data/local/auth_local_data_source.dart';
import 'package:flutter_showcase/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:flutter_showcase/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_showcase/features/onboarding/data/local/onboarding_local_data_source.dart';
import 'package:flutter_showcase/features/onboarding/data/repository/onboarding_repository_imp.dart';
import 'package:flutter_showcase/features/onboarding/domain/repository/onboarding_repository_i.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The main dependency injector for the application.
///
/// This provides access to the auth repository which is used by the app to
/// access the auth features.
///
/// The auth repository is configured with a remote data source and a local data
/// source. The remote data source is used to communicate with the backend API
/// and the local data source is used to store data locally on the device.
final getIt = GetIt.instance;

/// Initializes the dependency injector with the required dependencies.
///
/// This sets up the auth repository with a remote and local data source.
/// The remote data source is configured with a dio client and the base url
/// of the backend API. The local data source is configured with a secure
/// storage and shared preferences.
Future<void> setupLocator() async {
  const secureStorage = FlutterSecureStorage();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register the auth repository with a remote and local data source.
  getIt
    ..registerSingleton<IAuthRepository>(
      AuthRepository(
        authRemote: AuthRemoteDataSource(
          dio: Dio(),
          baseUrl: AppConfig.baseUrl,
        ),
        authLocalDataSource: AuthLocalDataSource(
          secureStorage: secureStorage,
          sharedPreferences: sharedPreferences,
        ),
      ),
    )
    ..registerSingleton<IOnboardingRepository>(
      OnboardingRepository(
        authLocalDataSource: OnboardingLocalDataSource(
          sharedPreferences: sharedPreferences,
        ),
      ),
    );
}
