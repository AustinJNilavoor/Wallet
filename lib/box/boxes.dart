import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/model/transactionclass.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
