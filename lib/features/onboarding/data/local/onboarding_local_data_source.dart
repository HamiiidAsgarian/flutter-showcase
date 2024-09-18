import 'package:flutter_showcase/core/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IOnboardingDataSource {
  Future<void> saveStatus({required bool status});
  Future<bool?> loadStatus();
}

class OnboardingLocalDataSource implements IOnboardingDataSource {
  OnboardingLocalDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferencesService = LocalStorageService(sharedPreferences);
  final LocalStorageService _sharedPreferencesService;

  @override
  Future<void> saveStatus({required bool status}) async {
    await _sharedPreferencesService.setIsOnboarded(value: status);
  }

  @override
  Future<bool?> loadStatus() async {
    return _sharedPreferencesService.getIsOnboarded();
  }
}
