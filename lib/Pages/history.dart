import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet/Pages/inputpage.dart';
import 'package:wallet/box/boxes.dart';
import 'package:wallet/model/transactionclass.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Transaction>>(
      valueListenable: Boxes.getTransactions().listenable(),
      builder: (context, box, _) {
        final transactions = box.values.toList().cast<Transaction>();

        return buildContent(transactions);
      },
    );
  }

  Widget buildContent(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No History',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      );
    } else {
      return ListView.builder(
        primary: false,
        padding: EdgeInsets.all(10),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          int revIndex = transactions.length - 1 - index;
          final transaction = transactions[revIndex];
          return buildBoxHis(context, transaction);
        },
      );
    }
  }

  Widget buildBoxHis(
    BuildContext context,
    Transaction transaction,
  ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final secLine = DateFormat.yMMMd().format(transaction.date) +
        ' | ' +
        //  transaction.category +' | ' +
        transaction.notes;
    final foramount = NumberFormat('##,##,##0').format(transaction.amount);
    final forbalance = NumberFormat('##,##,##0').format(transaction.balance);
    final amount = '\₹ ' + foramount;
    final balance = '\₹ ' + forbalance;
    // Long press to delete
    // tap to edit
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: () => showDialog(
            context: context, builder: (context) => DeleteDialog(transaction)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InputPage(
                      transaction: transaction,
                      onClickedDone: (amount, isExpense, date, category, source,
                              isTicked, balance, notes) =>
                          editTransaction(transaction, amount, isExpense, date,
                              category, source, isTicked, balance, notes),
                    )),
          );
        },
        child: Ink(
          width: (MediaQuery.of(context).size.width - 20),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${transaction.source}' + '  ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(transaction.category,
                            style: TextStyle(color: Colors.white70)),
                            SizedBox(
                      width: 5,),
                            transaction.isTicked? Icon(Icons.check,size: 15,color: Colors.blue,):SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      secLine,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      balance,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTransaction(Transaction transaction) {
    transaction.delete();
  }

  void editTransaction(
      Transaction transaction,
      double amount,
      bool isExpense,
      DateTime date,
      String category,
      String source,
      bool isTicked,
      double balance,
      String notes) {
    transaction.amount = amount;
    transaction.isExpense = isExpense;
    transaction.date = date;
    transaction.category = category;
    transaction.source = source;
    transaction.isTicked = isTicked;
    transaction.balance = balance;
    transaction.notes = notes;

    transaction.save();
  }

  Widget DeleteDialog(Transaction transaction) {
    return AlertDialog(
        contentPadding: EdgeInsets.only(top: 20, left: 20),
        backgroundColor: Colors.grey.shade900,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Text('Delete 1 transaction',
            style: TextStyle(color: Colors.white70)),
        actions: [cancelButton(context), deleteButton(transaction)]);
  }

  Widget deleteButton(Transaction transaction) => TextButton(
        child: Text('Delete'),
        onPressed: () {
          deleteTransaction(transaction);
          Navigator.of(context).pop();
        },
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );
}
