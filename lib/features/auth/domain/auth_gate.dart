import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_page.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_provider.dart';
import 'package:habit_wallet_lite/features/main_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    if (state.isLoggedIn) {
      return const MainPage();
    } else {
      return LoginPage();
    }
  }
}
