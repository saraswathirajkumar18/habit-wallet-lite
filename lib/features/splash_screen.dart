
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/auth/domain/auth_gate.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Load saved credentials (remember me)
    await ref.read(loginProvider.notifier).loadSavedCredentials();

    // Optional splash delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 🔑 Go to AuthGate (ONLY)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AuthGate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.account_balance_wallet,
                size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Habit Wallet Lite",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
