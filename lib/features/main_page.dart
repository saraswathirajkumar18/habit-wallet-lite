import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/profile/presentation/profile_screen.dart';
import 'package:habit_wallet_lite/features/summary/presentation/screens/summary_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/screens/home_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _index = 0;

  final pages = const [
    HomePage(),
    SummaryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: pages[_index],
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _index == 0
    ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTransactionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
    : null,
floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    switch (_index) {
      case 0:
        return AppBar(title: Center(child: Text('Home')));
      case 1:
        return  AppBar(title: Center(child: Text('Summary')));
      default:
        return AppBar(title: Center(child: Text('Profile')));
    }
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: (i) => setState(() => _index = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), label: 'Summary'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
