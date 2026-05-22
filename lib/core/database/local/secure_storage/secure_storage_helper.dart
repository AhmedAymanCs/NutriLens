import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrilens/core/constants/app_constants.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _storage;

  SecureStorageHelper(this._storage);

  Future<void> saveUserData(String value) async {
    await _storage.write(key: AppConstants.userSession, value: value);
  }

  Future<void> saveData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteData({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
