import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageData { email, rememberMe }

class LocalStorageService {
  // Constructor with dependency injection for better testability
  LocalStorageService(this._prefs);
  final SharedPreferences _prefs;

  //----email
  Future<void> setEmail(String value) async {
    await _prefs.setString(LocalStorageData.email.name, value);
  }

  Future<String?> getEmail() async {
    return _prefs.getString(LocalStorageData.email.name);
  }

  //----rememberMe
  Future<void> setRememberMe({required bool value}) async {
    await _prefs.setBool(LocalStorageData.rememberMe.name, value);
  }

  Future<bool?> getRememberMe() async {
    return _prefs.getBool(LocalStorageData.rememberMe.name);
  }

  // Optional: Clear data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
