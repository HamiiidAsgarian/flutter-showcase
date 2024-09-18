abstract class IOnboardingRepository {
  Future<bool> getIsOnboarded();

  Future<void> setIsOnboarded({required bool status});
}
