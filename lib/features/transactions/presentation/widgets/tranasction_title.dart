import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/core/constants/transaction_constants.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/screens/edit_transaction_page.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/providers/tranasaction_provider.dart';
import '../../data/models/transaction_model.dart';
enum _MenuAction {
  edit,
  delete,
}

class TransactionTile extends ConsumerStatefulWidget {
  final TransactionModel transaction;
  const TransactionTile(this.transaction, {super.key});

  @override
  ConsumerState<TransactionTile> createState() => _TransactionTileState();
}
class _TransactionTileState extends ConsumerState<TransactionTile> {
  bool showActions = false;

  String _formattedAmount() {
    final isExpense =
        widget.transaction.type == TransactionConstants.expense;
    final sign = isExpense ? '-' : '+';
    return "$sign ₹ ${widget.transaction.amount.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.transaction.category}=${widget.transaction.editedLocally}');
    return Column(
      children: [
       ListTile(
  title:Row(
        children: [
          Expanded(
            child: Text(
              widget.transaction.category,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          /// Edited locally badge
          if (widget.transaction.editedLocally)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Edited",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
  subtitle: Text(widget.transaction.note ?? ''),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        _formattedAmount(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: widget.transaction.type ==
                  TransactionConstants.expense
              ? Colors.red
              : Colors.green,
        ),
      ),
      const SizedBox(width: 10), 
      PopupMenuButton<_MenuAction>(
        onSelected: (action) {
          switch (action) {
            case _MenuAction.edit:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTransactionPage(
                    transaction: widget.transaction,
                  ),
                ),
              );
              break;

            case _MenuAction.delete:
              ref
                  .read(transactionProvider.notifier)
                  .delete(widget.transaction.id);
              break;
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(
            value: _MenuAction.edit,
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: _MenuAction.delete,
            child: Text('Delete'),
          ),
        ],
      ),
    ],
  ),
),

      ],
    );
  }
}

