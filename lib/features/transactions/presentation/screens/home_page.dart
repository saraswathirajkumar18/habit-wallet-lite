import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/screens/add_edit_transaction_screen.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/state/tranasaction_provider.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/widgets/tranasction_title.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ref.read(transactionProvider.notifier).sync();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditTransactionPage(),
            ),
          );
        },
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('No transactions'))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (_, i) => TransactionTile(transactions[i]),
            ),
    );
  }
}
