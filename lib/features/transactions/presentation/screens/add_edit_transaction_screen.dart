import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/core/utils/id_generator.dart';
import 'package:habit_wallet_lite/features/transactions/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/state/tranasaction_provider.dart';

class AddEditTransactionPage extends ConsumerWidget {
  const AddEditTransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Add Sample Transaction'),
          onPressed: () {
            ref.read(transactionProvider.notifier).add(
                  TransactionModel(
                    id: generateId(),
                    type: 'expense',
                    amount: 250,
                    category: 'Food',
                    note: 'Lunch',
                    date: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
