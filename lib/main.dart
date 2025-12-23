import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/providers/language_provider.dart';
import 'package:habit_wallet_lite/core/providers/theme_provider.dart';
import 'package:habit_wallet_lite/features/auth/presentation/login_page.dart';
import 'package:habit_wallet_lite/features/splash_screen.dart';
import 'package:habit_wallet_lite/features/transactions/core/db/hive_boxes.dart';
import 'package:habit_wallet_lite/features/transactions/data/models/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionModelAdapter());

  await Hive.openBox<TransactionModel>(HiveBoxes.transactions);

  runApp(const ProviderScope(child: MyApp()));
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Habit Wallet Lite',
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: SplashScreen(),
//     );
//   }
//}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Wallet Lite',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode, // react to user preference
      locale: locale,       // react to user selected language
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
