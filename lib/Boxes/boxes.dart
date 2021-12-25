import 'package:hive/hive.dart';
import 'package:wallet/model/transclass.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
