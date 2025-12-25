import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/core/constants/transaction_constants.dart';
import 'package:habit_wallet_lite/features/transactions/core/utils/id_generator.dart';
import 'package:habit_wallet_lite/features/transactions/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/providers/tranasaction_provider.dart';

class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() =>
      _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
final List<PlatformFile> _attachments = [];

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String? _selectedCategory;
 String _type = TransactionConstants.expense;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

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

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;
    if (_selectedCategory == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select a category")),
    );
    return;
  }
    ref.read(transactionProvider.notifier).add(
          TransactionModel(
            id: generateId(),
            type: _type,
            amount: amount,
            category: _selectedCategory!,
            note: _noteController.text,
            date: _selectedDate,
            updatedAt: DateTime.now(),
          ),
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Transaction Type
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
            child: Text(
              t.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
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
        
              const SizedBox(height: 20),
        
              /// Category dropdown
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
                decoration: const InputDecoration(labelText: "Category"),
              ),
        
              const SizedBox(height: 12),
        
              /// Note
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note"),
              ),
        
              const SizedBox(height: 12),
        
              /// Date & time
              ListTile(
                title: const Text("Date & Time"),
                subtitle: Text(
                  _selectedDate.toString(),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),
        
              const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.attach_file),
          label: Text(
            _attachments.isEmpty
          ? "Add Attachment"
          : "Attachments (${_attachments.length})",
          ),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
            );
        
            if (result != null) {
        setState(() {
          _attachments.addAll(result.files);
        });
            }
          },
        ),
        SizedBox(height:30),
        
              /// Buttons
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
                      onPressed: _saveTransaction,
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
