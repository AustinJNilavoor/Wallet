import 'package:hive/hive.dart';

part 'transclass.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late double amount;

  @HiveField(1)
  late bool isExpense = true;

  @HiveField(2)
  late DateTime createdDate;

  @HiveField(3)
  late String cate;

  @HiveField(4)
  late String tf;

  @HiveField(5)
  late String notes;

}
