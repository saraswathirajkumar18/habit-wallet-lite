import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/main_page.dart';

import 'login_provider.dart';


class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});
  
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
@override

@override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    ref.listen<LoginState>(loginProvider, (prev, next) {
      if (!mounted) return;

      // ✅ defer side effects
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        if (next.isLoggedIn && prev?.isLoggedIn != true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainPage()),
          );
        }

        if (next.error != null && prev?.error != next.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error!)),
          );
        }
      });
          });
  // void initState() {
  //   super.initState();

  //   ref.listen<LoginState>(loginProvider, (prev, next) {
  //     if (!mounted) return;

  //     if (next.isLoggedIn && prev?.isLoggedIn != true) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (_) => const MainPage()),
  //       );
  //     }

  //     if (next.error != null && prev?.error != next.error) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(next.error!)),
  //       );
  //     }
  //   }
  //   );
  // }
  // @override
  // Widget build(BuildContext context) {
  //    final state = ref.watch(loginProvider);
   
  
   

    // Autofill saved email (once)
    // if (state.email != null && _emailController.text.isEmpty) {
    //   _emailController.text = state.email!;
    // }

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _pinController,
              decoration: const InputDecoration(labelText: "PIN"),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: state.rememberMe,
                  onChanged: (value) {
                    ref
                        .read(loginProvider.notifier)
                        .updateRememberMe(value ?? false);
                  },
                ),
                const Text("Remember me"),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.loading
                    ? null
                    : () {
                        final email = _emailController.text.trim();
                        final pin = _pinController.text.trim();

                        // UI validation
                        if (!isValidEmail(email)) {
                          _showSnack(context, "Enter a valid email");
                          return;
                        }

                        if (!isValidPin(pin)) {
                          _showSnack(
                              context, "PIN must be at least 4 digits");
                          return;
                        }

                        // Trigger login (NO navigation here)
                        ref
                            .read(loginProvider.notifier)
                            .login(email, pin);
                      },
                child: state.loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool isValidEmail(String email) {
    return email.contains('@') &&
        email.contains('.') &&
        email.indexOf('@') < email.lastIndexOf('.');
  }

  bool isValidPin(String pin) {
    return pin.length >= 4 && int.tryParse(pin) != null;
  }
  
  }
