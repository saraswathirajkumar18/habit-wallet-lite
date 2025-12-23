import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;

  const TransactionTile(this.tx, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${tx.category} ₹${tx.amount}'),
      subtitle: Text(tx.note ?? ''),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(tx.type),
          if (tx.editedLocally)
            const Text(
              'Edited locally',
              style: TextStyle(color: Colors.orange, fontSize: 11),
            ),
        ],
      ),
    );
  }
}
