// ignore_for_file: unused_field

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final String _keyAccessToken = "_keyToken";

  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future saveToken(String token) async {
    await storage.write(key: _keyAccessToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyAccessToken);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _keyAccessToken);
  }
}
