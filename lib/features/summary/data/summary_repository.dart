
import 'package:habit_wallet_lite/features/transactions/data/repository/transaction_repository.dart';

import '../domain/summary_model.dart';


class SummaryRepository {
  final TransactionRepository transactionRepo;

  SummaryRepository(this.transactionRepo);

  SummaryModel getMonthlySummary( {DateTime? month}) {
  final currentMonth = month ?? DateTime.now();
  final transactions = transactionRepo.fetchFromHive();

  final monthTransactions = transactions.where((tx) =>
      tx.date.year == currentMonth.year &&
      tx.date.month == currentMonth.month);

  double income = 0;
  double expense = 0;
  final categoryMap = <String, double>{};

  for (var tx in monthTransactions) {
    if (tx.type == 'income') {
      income += tx.amount;
    } else {
      expense += tx.amount;
    }
    categoryMap[tx.category] = (categoryMap[tx.category] ?? 0) + tx.amount;
  }

  final balance = income - expense;

  return SummaryModel(
    totalIncome: income,
    totalExpense: expense,
    balance: balance,
    categoryBreakdown: categoryMap,
  );
}

}
