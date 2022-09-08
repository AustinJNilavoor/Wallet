import 'package:hive/hive.dart';

part 'transactionclass.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late double amount;

  @HiveField(1)
  late bool isExpense;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late String category;

  @HiveField(4)
  late String source;

  @HiveField(5)
  late bool isTicked;

  @HiveField(6)
  late double balance;

  @HiveField(7)
  late String notes;
}