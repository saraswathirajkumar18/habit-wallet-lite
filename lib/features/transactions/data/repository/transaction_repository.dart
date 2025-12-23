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

  /// ADD
  Future<void> save(TransactionModel tx) async {
    tx.editedLocally = true;
    await local.save(tx);
  }

  /// EDIT
  Future<void> update(TransactionModel tx) async {
    tx.editedLocally = true;
    await local.save(tx); // same key → overwrite
  }

  /// DELETE
  Future<void> delete(String id) async {
    await local.delete(id);
  
  }

  /// SYNC
  Future<void> sync() async {
    final edited = local
        .getAll()
        .where((t) => t.editedLocally)
        .toList();

    await remote.sendTransactions(edited);

    for (final tx in edited) {
      tx.editedLocally = false;
      await tx.save(); // HiveObject save
    }
  }
}
