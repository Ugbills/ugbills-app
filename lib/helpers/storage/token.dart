import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }

  Future<bool> isAuthenticated() async {
    String? token = await getToken();
    return token != null;
  }
}
