import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/presentation/providers/tranasaction_provider.dart';
import '../../domain/summary_model.dart';
import '../../data/summary_repository.dart';

final summaryProvider = Provider<SummaryModel>((ref) {
  //final transactions = ref.watch(transactionProvider);
  final repo = SummaryRepository(ref.read(transactionProvider.notifier).repo);

  return repo.getMonthlySummary();
});
