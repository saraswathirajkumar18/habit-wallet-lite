import '../local/transaction_hive_service.dart';
import '../remote/transaction_api_service.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final TransactionHiveService local;
  final TransactionApiService remote;

  TransactionRepository(this.local, this.remote);

  List<TransactionModel> fetchFromHive() {
    return local.getAll();
  }

  Future<void> save(TransactionModel tx) async {
    await local.save(tx);
  }

  Future<void> sync() async {
    final edited = local
        .getAll()
        .where((t) => t.editedLocally)
        .toList();

    await remote.sendTransactions(edited);

    for (final tx in edited) {
      tx.editedLocally = false;
      await tx.save();
    }
  }
}
