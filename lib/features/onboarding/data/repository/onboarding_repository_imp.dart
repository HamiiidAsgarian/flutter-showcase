import 'package:flutter_showcase/features/onboarding/data/local/onboarding_local_data_source.dart';
import 'package:flutter_showcase/features/onboarding/domain/repository/onboarding_repository_i.dart';

class OnboardingRepository implements IOnboardingRepository {
  OnboardingRepository({
    required OnboardingLocalDataSource authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource;

  final OnboardingLocalDataSource _authLocalDataSource;

  @override
  Future<bool> getIsOnboarded() async {
    final isOnboarded = await _authLocalDataSource.loadStatus() ?? false;
    return isOnboarded;
  }

  @override
  Future<void> setIsOnboarded({required bool status}) {
    return _authLocalDataSource.saveStatus(status: status);
  }
}
