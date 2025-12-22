
import 'package:habit_wallet_lite/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:habit_wallet_lite/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
final AuthLocalDataSource local;
AuthRepositoryImpl(this.local);
@override
Future<bool> login(String email,String pin) async
  {
if(email.isEmpty|| pin.isEmpty)
{
  throw Exception('Email and PIN is required');
}
return true;
  }
  @override
  Future<void> saveCredentials(String email,String pin)
  {
return local.saveCredentials(email,pin);
  }
  @override
  Future<void> clearCredentials(){
    return local.clear();
  }
@override
  Future<String?> getEmail() {
    return local.getEmail();
  }

  @override
  Future<String?> getPin() {
    return local.getPin();
  }
}