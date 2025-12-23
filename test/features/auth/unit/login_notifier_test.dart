import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_provider.dart';

import '../mock/mock_auth_repo.dart';


void main()
{
test('login success with rememberMe saves credentials and logs in', () async {
  final repo = MockAuthRepo();
  final notifier = LoginNotifier(repo);

  notifier.updateRememberMe(true);

  await notifier.login('test@mail.com', '12345');

  expect(notifier.state.isLoggedIn, true); // state change
  expect(repo.saveCalled, true);           // saveCredentials called
});
}