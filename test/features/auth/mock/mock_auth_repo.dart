import 'package:habit_wallet_lite/features/auth/domain/auth_repository.dart';

class MockAuthRepo implements AuthRepository {
  bool loginResult = true;
  bool saveCalled = false; // ✅ Track saveCredentials call

  @override
  Future<bool> login(String email, String pin) async => loginResult;

  @override
  Future<void> saveCredentials(String email, String pin) async {
    saveCalled = true; // ✅ mark it as called
  }

  @override
  Future<void> clearCredentials() async {}

  @override
  Future<String?> getEmail() async => 'test@mail.com';

  @override
  Future<String?> getPin() async => '12345';
}
