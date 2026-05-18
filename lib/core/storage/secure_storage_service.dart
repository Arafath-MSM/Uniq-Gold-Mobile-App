import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const String _basicAuthKey = 'basic_auth';
  static const String _usernameKey = 'wp_username';
  static const String _appPasswordKey = 'wp_app_password';

  Future<void> saveBasicAuth({
    required String username,
    required String appPassword,
  }) async {
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _appPasswordKey, value: appPassword);
    final String encoded = base64Encode(utf8.encode('$username:$appPassword'));
    await _storage.write(key: _basicAuthKey, value: 'Basic $encoded');
  }

  Future<String?> readAuthorizationHeader() async {
    return _storage.read(key: _basicAuthKey);
  }

  Future<void> clearAuth() async {
    await _storage.delete(key: _basicAuthKey);
    await _storage.delete(key: _usernameKey);
    await _storage.delete(key: _appPasswordKey);
  }
}
