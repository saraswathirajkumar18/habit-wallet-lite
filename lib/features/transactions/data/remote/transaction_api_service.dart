
import 'package:habit_wallet_lite/features/transactions/core/network/api_client.dart';

import '../models/transaction_model.dart';

class TransactionApiService {
  final ApiClient client = ApiClient();

  Future<void> sendTransactions(List<TransactionModel> txs) async {
    for (final tx in txs) {
      await client.post('/transactions', {
        'id': tx.id,
        'amount': tx.amount,
        'category': tx.category,
        'updatedAt': tx.updatedAt.toIso8601String(),
      });
    }
  }
}
