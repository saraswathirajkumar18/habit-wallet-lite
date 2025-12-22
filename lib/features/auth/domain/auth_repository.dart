abstract class AuthRepository{
  Future<bool> login(String email,String pin);
  Future<void> saveCredentials(String email,String pin);
  Future<void> clearCredentials();
  Future<String?> getEmail();
  Future<String?> getPin();
}