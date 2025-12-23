import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/providers/tranasaction_provider.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/widgets/tranasction_title.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

 @override
Widget build(BuildContext context, WidgetRef ref) {
  // Watch transactions
  final transactions = ref.watch(transactionProvider);

  return transactions.isEmpty
      ? const Center(child: Text('No transactions'))
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (_, i) => TransactionTile(transactions[i]),
        );
}
}