import 'package:flutter/material.dart';
import 'package:wallet/model/transclass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Boxes/boxes.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
          backgroundColor: Color(0x00),
          elevation: 0,
          title: Text('Wallet History'),
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
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          int revIndex = transactions.length - 1 - index;
          final transaction = transactions[revIndex];

          return buildTransaction(context, transaction);
        },
      );
    }
  }

  Widget buildTransaction(
      BuildContext context,
      Transaction transaction,
      ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final secLine = DateFormat.yMMMd().format(transaction.createdDate) + ' | ' + transaction.notes;
    final amou = transaction.amount.toDouble();
    final foramount = NumberFormat('##,##,##0').format(amou);
    final amount = '\₹ ' + foramount;

    if(transaction.tf == 'Wallet'){
      return Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Container(
          height: 75,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 18,right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(transaction.cate,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                    Text(secLine,
                      style: TextStyle(
                          color: Colors.white)),

                  ],),
                Text('$amount',
                  style: TextStyle(
                      color: color,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),)
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xff0f2027),
              borderRadius: BorderRadius.circular(25)),
        ),
      );
    }
    else
      {
        return Divider(color: Color(0x00), height: 0, thickness: 0,);
      }
  }
}
