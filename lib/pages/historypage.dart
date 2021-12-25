import 'package:flutter/material.dart';
import 'package:wallet/model/transclass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Boxes/boxes.dart';
import 'package:intl/intl.dart';
import 'package:wallet/pages/inputpage.dart';
class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0,0.5,1.0],
          colors: [
            Color(0xff0f2027),
            Color(0xff203a43),
            Color(0xff2c5364),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00000000),
          elevation: 0,
          title: Text('History'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text('Available Soon',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),),
                      backgroundColor: Color(0xff0f2027)
                  )
                  );
                },
              ),
            ]
        ),
        body: ValueListenableBuilder<Box<Transaction>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<Transaction>();

            return buildContent(transactions);
          },
        ),
      ),
    );
  }

  Widget buildContent(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No History',
          style: TextStyle(fontSize: 25,color: Colors.white),
        ),
      );
    } else {
      return Scrollbar(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10),
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            int revIndex = transactions.length - 1 - index;
            final transaction = transactions[revIndex];
            return buildTransaction(context, transaction);
          },
        ),
      );
    }
  }

  Widget buildTransaction(
      BuildContext context,
      Transaction transaction,
      ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final secLine = DateFormat.yMMMd().format(transaction.createdDate) + ' | ' + transaction.tf + ' | ' + transaction.notes;
    final amou = transaction.amount.toDouble();
    final foramount = NumberFormat('##,##,##0').format(amou);
    final amount = '\₹ ' + foramount;


    return Container(
      color: Color(0x00000000),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            title: Text(
              transaction.cate,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(secLine),
            trailing: Text(
              amount,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            backgroundColor: Color(0xff0f2027),
            collapsedTextColor: Colors.white,
            textColor: Colors.white,
            collapsedBackgroundColor: Color(0xff0f2027),
            children: [
              buildButtons(context, transaction),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, Transaction transaction) => Row(
    children: [
      Expanded(
        child: TextButton.icon(
          label: Text('Edit'),
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyInputPage(
                  transaction: transaction,
                  onClickedDone: (amount, isExpense, dateSel, drpcat, drptf, notes) =>
                      editTransaction(transaction, amount, isExpense, dateSel, drpcat, drptf, notes),
                ),
              ),
            );
          },
        ),
      ),
      Expanded(
        child: TextButton.icon(
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: () {
            deleteTransaction(transaction);
          },
        ),
      )
    ],
  );
  void deleteTransaction(Transaction transaction) {
    transaction.delete();
  }

  void editTransaction(
      Transaction transaction,
      double amount,
      bool isExpense,
      DateTime dateSel,
      String drpcat,
      String drptf,
      String notes
      ) {
    transaction.amount = amount;
    transaction.isExpense = isExpense;
    transaction.createdDate = dateSel;
    transaction.cate = drpcat;
    transaction.tf = drptf;
    transaction.notes = notes;

    transaction.save();
  }
}
