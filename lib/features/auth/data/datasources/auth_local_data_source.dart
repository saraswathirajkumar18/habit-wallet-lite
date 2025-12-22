import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;
  AuthLocalDataSource(this.storage);
  static const _emailKey='email';
  static const _pinKey='pin';
  Future<void> saveCredentials(String email,String pin) async
  {
await storage.write(key:_emailKey,value:email);
await storage.write(key:_pinKey,value:pin);
  }
  Future<String?> getEmail() {
    return storage.read(key: _emailKey);
  }

  Future<String?> getPin() {
    return storage.read(key: _pinKey);
  }
  Future<void> clear() async {
    await storage.delete(key: _emailKey);
    await storage.delete(key: _pinKey);
  }
}