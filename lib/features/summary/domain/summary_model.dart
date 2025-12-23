class SummaryModel {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final Map<String, double> categoryBreakdown;

  SummaryModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.categoryBreakdown,
  });
}
