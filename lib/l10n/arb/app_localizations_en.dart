import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle1 => 'Location and destination';

  @override
  String get onboardingMessage1 =>
      'Your destination is at your fingerprint.Open the app and enter where you want to go ';

  @override
  String get onboardingTitle2 => 'Services quality';

  @override
  String get onboardingMessage2 =>
      'You have access to the best quality services ever';

  @override
  String get onboardingTitle3 => 'Be Comfortable';

  @override
  String get onboardingMessage3 =>
      'Make sure that you will have a relax time with family';

  @override
  String get next => 'Next';

  @override
  String get proceed => 'Proceed';

  @override
  String get logIntoYourAccount => 'Log Into Your Account';

  @override
  String get createYourAccount => 'Create Your Account';

  @override
  String get email => 'email';

  @override
  String get password => 'password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get login => 'Login';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get dontHaveAnAccount => 'Don\'t you have an account';

  @override
  String get dontRememberYourPassword => 'Don\'t remember your password?';

  @override
  String get signup => 'Signup';

  @override
  String get emailIsIncorrect => 'Email Is Incorrect';

  @override
  String get passwordRequirement1 =>
      'Password must be at least 8 characters long';

  @override
  String get passwordRequirement2 =>
      'Password must contain at least one upper case letter';

  @override
  String get passwordRequirement3 =>
      'Password must contain at least one lower case letter';

  @override
  String get passwordRequirement4 =>
      'Password must contain at least one number';

  @override
  String get passwordRequirement5 =>
      'Password must contain at least one special character';

  @override
  String get successMessage => 'success!';

  @override
  String get failMessage => 'Autentication failed!';
}
