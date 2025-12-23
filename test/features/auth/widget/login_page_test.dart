import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_page.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_provider.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/screens/home_page.dart';


import '../mock/mock_auth_repo.dart';
void main(){
testWidgets('navigates to HomePage after successful login', (tester) async {
  final container = ProviderContainer(
    overrides: [
      loginProvider.overrideWith(
        (_) => LoginNotifier(MockAuthRepo())
          ..state = LoginState(isLoggedIn: true),
      ),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(

      container: container,
      child:  MaterialApp(
        home: LoginPage(),
      ),
    ),
  );

  await tester.pumpAndSettle();

  expect(find.byType(HomePage), findsOneWidget);
});
}
