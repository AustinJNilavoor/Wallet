import 'package:flutter/material.dart';
import 'package:wallet/model/transclass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Boxes/boxes.dart';
import 'package:intl/intl.dart';

class LentPage extends StatefulWidget {

  @override
  _LentPageState createState() => _LentPageState();
}

class _LentPageState extends State<LentPage> {
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
            title: Text('Lend History'),
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
        body: Column(
          children: [
            Container(
              height: 100,
              child: ValueListenableBuilder<Box<Transaction>>(
                valueListenable: Boxes.getTransactions().listenable(),
                builder: (context, box, _) {
                  final transactions = box.values.toList().cast<Transaction>();
                  Set nameset = {};
                  int len = transactions.length;
                  for(len; len>0; len--){
                    final tra = transactions[len-1];
                    if(tra.cate == 'Lend') {
                      final names = tra.notes;
                      nameset.add(names);
                    }
                  }
                  int setlen = nameset.length;
                  for(setlen;setlen>0;setlen--){
                    final elem = nameset.elementAt(setlen-1);
                    final netAmount = transactions.fold<double>(
                      0,
                          (previousValue, transaction) => transaction.notes == elem && transaction.cate == 'Lend'
                          ? transaction.isExpense
                          ? previousValue + transaction.amount
                          : previousValue - transaction.amount
                          : previousValue + 0,
                    );
                    if(netAmount == 0){
                      nameset.remove(elem);
                    }
                  }
                  return buildLend(nameset,transactions);
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<Transaction>>(
                valueListenable: Boxes.getTransactions().listenable(),
                builder: (context, box, _) {
                  final transactions = box.values.toList().cast<Transaction>();

                  return buildContent(transactions);
                },
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget buildLend(Set nameset,List<Transaction> transactions){
    if (nameset.isEmpty) {
      return Center(
        child: Text(
          'Nothing pending',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          itemCount: nameset.length,
          itemBuilder: (BuildContext context, int index) {
            final insta = nameset.elementAt(index);
            final netAmount = transactions.fold<double>(
              0,
                  (previousValue, transaction) => transaction.notes == insta && transaction.cate == 'Lend'
                  ? transaction.isExpense
                  ? previousValue + transaction.amount
                  : previousValue - transaction.amount
                  : previousValue + 0,
            );
            return buildLendEach(context,insta,netAmount);
          },
        ),
      );
    }
  }

  Widget buildLendEach(BuildContext context,insta,netAmount){
    final color = netAmount<0 ? Colors.red : Colors.green;
    final netamo = netAmount > 0 ? netAmount : 0-netAmount;
    final newAmount = NumberFormat('##,##,##0').format(netamo);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0,1.0],
              colors: [
                Color(0xccc33764),
                Color(0xcc1d2671),
              ],
            )),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(insta,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text('  ₹ $newAmount',
                style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),),
            )
          ],
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
    final color = transaction.isExpense ? Colors.green : Colors.red;
    final secLine = DateFormat.yMMMd().format(transaction.createdDate);
    final amou = transaction.amount.toDouble();
    final foramount = NumberFormat('##,##,##0').format(amou);
    final amount = '\₹ ' + foramount;

    if(transaction.cate == 'Lend') {
      return Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Container(
          height: 75,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(transaction.notes,
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
      return Divider(color: Color(0x00), height: 0,);
    }
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}