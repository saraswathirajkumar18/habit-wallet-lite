import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/features/transactions/core/db/hive_boxes.dart';
import 'package:habit_wallet_lite/features/transactions/data/local/transaction_hive_service.dart';
import 'package:habit_wallet_lite/features/transactions/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/features/transactions/data/remote/transaction_api_service.dart';
import 'package:habit_wallet_lite/features/transactions/data/repository/transaction_repository.dart';
import 'package:hive/hive.dart';


final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<TransactionModel>>(
  (ref) {
    final box = Hive.box<TransactionModel>(HiveBoxes.transactions);
    return TransactionNotifier(
      TransactionRepository(
        TransactionHiveService(box),
        TransactionApiService(),
      ),
    );
  },
);

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  final TransactionRepository repo;

  TransactionNotifier(this.repo) : super(repo.fetchFromHive());

  Future<void> add(TransactionModel tx) async {
    await repo.save(tx);
    state = repo.fetchFromHive();
  }

  Future<void> sync() async {
    await repo.sync();
    state = repo.fetchFromHive();
  }
}
