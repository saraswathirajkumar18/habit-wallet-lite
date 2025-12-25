import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_wallet_lite/core/providers/language_provider.dart';
import 'package:habit_wallet_lite/core/providers/theme_provider.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_provider.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Theme switch
            Row(
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (val) {
                    ref.read(themeProvider.notifier).state =
                        val ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Language switch
            Text('Language',style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            DropdownButton<Locale>(
              value: locale,
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ta'), child: Text('தமிழ்')),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref.read(languageProvider.notifier).state = val;
                }
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: Text(AppLocalizations.of(context)!.logout),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ref.read(loginProvider.notifier).logout();
        //           Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => LoginPage()),
        // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
