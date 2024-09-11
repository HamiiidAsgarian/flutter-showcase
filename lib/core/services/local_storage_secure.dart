import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_showcase/features/auth/data/models/token_model.dart';

enum LocalStorageSecureData { password, accessToken, refreshToken }

class LocalStorageSecureService {
  // Dependency injection for better testability
  LocalStorageSecureService(this._storage);
  final FlutterSecureStorage _storage;

  //----password
  Future<void> setPassword(String value) async {
    await _storage.write(
      key: LocalStorageSecureData.password.name,
      value: value,
    );
  }

  Future<String?> getPassword() async {
    return _storage.read(key: LocalStorageSecureData.password.name);
  }

  //----token
  Future<void> setTokens(TokenModel token) async {
    await _storage.write(
      key: LocalStorageSecureData.accessToken.name,
      value: token.accessToken,
    );
    await _storage.write(
      key: LocalStorageSecureData.refreshToken.name,
      value: token.refreshToken,
    );
  }

  Future<TokenModel?> getToken() async {
    final accessToken =
        await _storage.read(key: LocalStorageSecureData.accessToken.name);
    final refreshToken =
        await _storage.read(key: LocalStorageSecureData.refreshToken.name);

    if (accessToken != null && refreshToken != null) {
      return TokenModel(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      return null;
    }
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
