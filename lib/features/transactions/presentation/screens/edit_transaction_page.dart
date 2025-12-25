import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/core/constants/transaction_constants.dart';
import 'package:habit_wallet_lite/features/transactions/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/providers/tranasaction_provider.dart';

class EditTransactionPage extends ConsumerStatefulWidget {
  final TransactionModel transaction;

  const EditTransactionPage({
    super.key,
    required this.transaction,
  });

  @override
  ConsumerState<EditTransactionPage> createState() =>
      _EditTransactionPageState();
}

class _EditTransactionPageState
    extends ConsumerState<EditTransactionPage> {
  /// Controllers
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  /// State
  late String _selectedCategory;
  late String _type;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    final tx = widget.transaction;

    _amountController.text = tx.amount.toString();
    _noteController.text = tx.note ?? '';
    _selectedCategory = tx.category;
    _type = tx.type;
    _selectedDate = tx.date;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  /// Date & Time Picker
  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null) return;
    if (!mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    if (!mounted || time == null) return;

    //if (time == null) return;

    setState(() {
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  /// UPDATE Transaction
  void _updateTransaction() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final updatedTx = TransactionModel(
      id: widget.transaction.id, // KEEP SAME ID
      type: _type,
      amount: amount,
      category: _selectedCategory,
      note: _noteController.text,
      date: _selectedDate,
      updatedAt: DateTime.now(),
    );

    ref.read(transactionProvider.notifier).update(updatedTx);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToggleButtons(
  isSelected: TransactionConstants.types
      .map((t) => t == _type)
      .toList(),
  onPressed: (index) {
    setState(() {
      _type = TransactionConstants.types[index]; 
    });
  },
  borderRadius: BorderRadius.circular(8),
  children: TransactionConstants.types
      .map(
        (t) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(t.toUpperCase()),
        ),
      )
      .toList(),
),

            const SizedBox(height: 12),
            /// Amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                prefixText: "₹ ",
              ),
            ),
            const SizedBox(height: 12),
             /// Transaction Type


            /// Category
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: TransactionConstants.categories
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
              decoration: const InputDecoration(
                labelText: "Category",
              ),
            ),

            const SizedBox(height: 12),

            /// Note
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: "Note",
              ),
            ),

            const SizedBox(height: 12),

            /// Date & Time
            ListTile(
              title: const Text("Date & Time"),
              subtitle: Text(
                _selectedDate.toString(),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDateTime,
            ),

            const Spacer(),

            /// Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _updateTransaction,
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
