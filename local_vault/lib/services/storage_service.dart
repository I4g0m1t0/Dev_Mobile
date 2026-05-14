import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  
  final String _tokenKey = 'auth_token';

  // Salva o token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Recupera o token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Deleta o token
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}