
import 'package:flutter/foundation.dart';
import 'package:mithub_app/core/network/api_env.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';

class CoreHttpRepository {
  static const coreTokenIdKey = 'token_id';
  static const coreTokenKey = 'token';
  static const coreRefreshTokenKey = 'refresh_token';
  static const coreEnv = 'current_environment';

  final CoreSecureStorage secureStorage;

  CoreHttpRepository(this.secureStorage);

  Future<void> setToken(String token) =>
      secureStorage.setString(coreTokenKey, token);

  // can be empty
  Future<String> getToken() => secureStorage.getString(coreTokenKey);

  Future<void> setTokenId(String tokenId) =>
      secureStorage.setString(coreTokenIdKey, tokenId);

  Future<String> getTokenId() => secureStorage.getString(coreTokenIdKey);

  Future<void> setRefreshToken(String refreshToken) =>
      secureStorage.setString(coreRefreshTokenKey, refreshToken);

  Future<String> getRefreshToken() =>
      secureStorage.getString(coreRefreshTokenKey);

  Future<ApiEnv> getEnv() {
    return secureStorage.getString(coreEnv).then((envName) {
      if (envName.isNotEmpty) {
        return ApiEnv.values.firstWhere((element) => element.name == envName);
      }
      return defaultEnv();
    });
  }

  Future setEnv(ApiEnv env) => secureStorage.setString(coreEnv, env.name);

  Future<ApiEnv> defaultEnv() async {
    bool isRelease = kReleaseMode;
    return isRelease == true
        ? ApiEnv.prod
        :  ApiEnv.dev;
  }

  List<ApiEnv> allEnvs() => ApiEnv.values;

  Future<void> clear() async {
    await secureStorage.deleteData(coreTokenKey);
    await secureStorage.deleteData(coreRefreshTokenKey);
    await secureStorage.deleteData(coreEnv);
    await secureStorage.deleteData(coreTokenIdKey);
  }
}
