
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreSecureStorage {
  static const key = 'key';
  static const save = 'save';

  late final FlutterSecureStorage _secureStorage;

  /// private constructor
  CoreSecureStorage._({
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
  }) {
    try {
      androidOptions ??= const AndroidOptions(
        encryptedSharedPreferences: true,
      );

      iosOptions ??= const IOSOptions();

      _secureStorage = FlutterSecureStorage(
        aOptions: androidOptions,
        iOptions: iosOptions,
      );

      clearSecureStorageOnReinstall();
    } on Exception catch (ex, stack) {
      FirebaseCrashlytics.instance.recordError(ex, stack);
    }
  }

  static CoreSecureStorage defaultInstance = CoreSecureStorage._();

  Future<void> setString(String key, String value) async {
    await _write(key, value);
  }

  Future<void> setListString(String key, List<String> value) async {
    await _write(key, value.join(','));
  }

  Future<String> getString(String key) async {
    var data = await _secureStorage.read(key: key);
    return data ?? '';
  }

  Future<List<String>> getList(String key) async {
    var data = await _secureStorage.read(key: key);
    return data?.split(',') ?? [];
  }

  Future<void> setInt(String key, int value) async {
    await _write(key, value.toString());
  }

  Future<int> getInt(String key) async {
    var data = await _secureStorage.read(key: key);
    return int.parse(data ?? '0');
  }

  Future<void> setDouble(String key, double value) async {
    await _write(key, value.toString());
  }

  Future<double> getDouble(String key) async {
    var data = await _secureStorage.read(key: key);
    return double.parse(data ?? '0.0');
  }

  Future<void> setBoolean(String key, bool value) async {
    await _write(key, value.toString());
  }

  Future<bool> getBoolean(String key) async {
    var data = await _secureStorage.read(key: key);
    if (data?.toLowerCase() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await _secureStorage.deleteAll();
  }

  Future<Map<String, String>> getAll() {
    return _secureStorage.readAll();
  }

  Future<void> _write(String key, String? value) {
    try {
      return _secureStorage.write(key: key, value: value);
    } on Exception catch(ex, stack) {
      FirebaseCrashlytics.instance.recordError(ex, stack);
      return Future.value();
    }
  }

  /// Additional code to clear storage on reinstall
  /// workaround keychain iOS is not cleared on reinstall
  clearSecureStorageOnReinstall() async {
    String key = 'hasRunBefore';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!(sharedPreferences.getBool(key) ?? false)) {
      await deleteAllData();
      await sharedPreferences.setBool(key, true);
    }
  }
}
