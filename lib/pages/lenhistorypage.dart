
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet/box/boxes.dart';
import 'package:wallet/model/transactionclass.dart';
import 'package:wallet/pages/inputpage.dart';

class LendHistoryPage extends StatefulWidget {
  const LendHistoryPage({Key? key}) : super(key: key);

  @override
  State<LendHistoryPage> createState() => _LendHistoryPageState();
}

class _LendHistoryPageState extends State<LendHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0.0,
        title: const Text(
          'History',
        ),
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Transaction>();

          return buildContent(transactions);
        },
      ),
    );
  }

  Widget buildContent(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No History',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      );
    } else {
      return ListView.builder(
        primary: false,
        padding: const EdgeInsets.all(10),
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
    final secLine = '${DateFormat.yMMMd().format(transaction.date)} | ${transaction.notes}';
    final foramount = NumberFormat('##,##,##0').format(transaction.amount);
    final forlenTotal = NumberFormat('##,##,##0').format(transaction.lendTotal);
    final amount = '₹ $foramount';
    final lendTotal = '₹ $forlenTotal';
    // Long press to delete
    // tap to edit
    if (transaction.isTicked) {
      return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: () => showDialog(
            context: context, builder: (context) => deleteDialog(transaction)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InputPage(
                      transaction: transaction,
                      onClickedDone: (amount, isExpense, date, category, source,
                              isTicked, balance, notes, lentTotal) =>
                          editTransaction(
                              transaction,
                              amount,
                              isExpense,
                              date,
                              category,
                              source,
                              isTicked,
                              balance,
                              notes,
                              lentTotal),
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
                      transaction.source,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(transaction.category,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      secLine,
                      style: const TextStyle(color: Colors.white70),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      lendTotal,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    } else {
      return const SizedBox();
    }
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
      String notes,
      double lendTotal) {
    transaction.amount = amount;
    transaction.isExpense = isExpense;
    transaction.date = date;
    transaction.category = category;
    transaction.source = source;
    transaction.isTicked = isTicked;
    transaction.balance = balance;
    transaction.notes = notes;
    transaction.lendTotal = lendTotal;

    transaction.save();
  }

  Widget deleteDialog(Transaction transaction) {
    return AlertDialog(
        contentPadding: const EdgeInsets.only(top: 20, left: 20),
        backgroundColor: Colors.grey.shade900,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: const Text('Delete 1 transaction',
            style: TextStyle(color: Colors.white70)),
        actions: [cancelButton(context), deleteButton(transaction)]);
  }

  Widget deleteButton(Transaction transaction) => TextButton(
        child: const Text('Delete'),
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
