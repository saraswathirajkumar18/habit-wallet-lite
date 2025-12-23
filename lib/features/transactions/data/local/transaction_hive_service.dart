import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionHiveService {
  final Box<TransactionModel> box;

  TransactionHiveService(this.box);

  List<TransactionModel> getAll() {
    return box.values.toList();
  }

  Future<void> save(TransactionModel tx) async {
    tx.editedLocally = true;
    tx.updatedAt = DateTime.now();
    await box.put(tx.id, tx);
  }
}
