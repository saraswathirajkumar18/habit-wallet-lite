
import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String category;

  @HiveField(4)
  String? note;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String? attachmentPath;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  bool editedLocally;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    this.note,
    required this.date,
    this.attachmentPath,
    required this.updatedAt,
    this.editedLocally = false,
  });
}
