import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_showcase/core/services/local_storage.dart';
import 'package:flutter_showcase/core/services/local_storage_secure.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';
import 'package:flutter_showcase/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveToken(TokenModel token);
  Future<TokenModel?> getToken();
  Future<void> saveUser(UserModel userModel);
  Future<void> removeLocals();
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  AuthLocalDataSource({
    required FlutterSecureStorage secureStorage,
    required SharedPreferences sharedPreferences,
  })  : _secureStorageService = LocalStorageSecureService(secureStorage),
        _sharedPreferencesService = LocalStorageService(sharedPreferences);
  final LocalStorageSecureService _secureStorageService;
  final LocalStorageService _sharedPreferencesService;

  @override
  Future<void> saveToken(TokenModel token) async {
    await _secureStorageService.setTokens(token);
  }

  Future<void> saveRememberMe({required bool value}) async {
    await _sharedPreferencesService.setRememberMe(value: value);
  }

  Future<bool> getRememberMe() async {
    return await _sharedPreferencesService.getRememberMe() ?? false;
  }

  @override
  Future<TokenModel?> getToken() async {
    return _secureStorageService.getToken();
  }

  @override
  Future<void> removeLocals() async {
    await _secureStorageService.clearAll();
    await _sharedPreferencesService.clearAll();
  }

  Future<UserModel?> getUser() async {
    final localPass = await _secureStorageService.getPassword();
    final localEmial = await _sharedPreferencesService.getEmail();

    if (localPass != null && localEmial != null) {
      return UserModel(email: localEmial, password: localPass);
    }

    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _secureStorageService.setPassword(user.password);
    await _sharedPreferencesService.setEmail(user.email);
  }
}
