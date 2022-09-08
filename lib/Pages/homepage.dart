import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet/Pages/inputpage.dart';
import 'package:wallet/globalvar.dart';
import 'package:wallet/model/transactionclass.dart';

import '../box/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InputPage(
                      onClickedDone: addTransaction,
                    )),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Transaction>();
          return buildBody(transactions);
        },
      ),
    );
  }

  Future addTransaction(
      double amount,
      bool isExpense,
      DateTime date,
      String category,
      String source,
      bool isTicked,
      double balance,
      String notes) async {
    final transaction = Transaction()
      ..amount = amount
      ..isExpense = isExpense
      ..date = date
      ..category = category
      ..source = source
      ..isTicked = isTicked
      ..balance = balance
      ..notes = notes;

    final box = Boxes.getTransactions();
    box.add(transaction);
  }

  Widget buildBody(List<Transaction> transactions) {
    final wallet = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Wallet'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );

    final bank = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Bank'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );

    final total = transactions.fold<double>(
        0,
        (previousValue, transaction) => transaction.isTicked
            ? previousValue + 0
            : transaction.isExpense
                ? previousValue - transaction.amount
                : previousValue + transaction.amount);

    final tab = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.isTicked
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
    final home = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Home'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
    final amazpay = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Amazon Pay'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
    final todayExp = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.date.day == DateTime.now().day
          ? transaction.isExpense
              ? previousValue + transaction.amount
              : previousValue + 0
          : previousValue + 0,
    );
    final todayInc = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.date.day == DateTime.now().day
          ? transaction.isExpense
              ? previousValue + 0
              : previousValue + transaction.amount
          : previousValue + 0,
    );

    Balance.walletbalance = wallet;
    Balance.bankbalance = bank;
    Balance.totalbalance = total;
    Balance.homebalance = home;
    Balance.amazpaybalance = amazpay;
    Balance.lendmoney = tab;
    final walletStr = NumberFormat('##,##,##0').format(wallet);
    final bankStr = NumberFormat('##,##,##0').format(bank);
    final moTab = tab < 0 ? -tab : tab;
    final tabStr = NumberFormat('##,##,##0').format(moTab);
    final color = tab < 0 ? Colors.red : Colors.green;
    final todayExpStr = NumberFormat('##,##,##0').format(todayExp);
    final todayIncStr = NumberFormat('##,##,##0').format(todayInc);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSBox(damount: walletStr),
              const SizedBox(
                width: 7,
              ),
              buildSBox(damount: bankStr)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            child: Center(
              child: Text(
                '₹ $tabStr',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 4),
                    child: Text('Today',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('₹ $todayIncStr',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      Text('₹ $todayExpStr',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          const Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
            thickness: 1.2,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shortcuts',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.add,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent History',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(
                    height: 5,
                  ),
                  buildRHistory(transactions)
                ],
              ),
            ),
          )),
          const SizedBox(
            height: 17,
          )
        ],
      ),
    );
  }

  Widget buildSBox({required String damount}) {
    return Container(
      height: 80,
      width: (MediaQuery.of(context).size.width - 30) / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Text(
              '₹ $damount',
              // Change text size
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
              // Change text size
              'Wallet',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRHistory(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No History',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // primary: false,
        padding: EdgeInsets.all(10),
        itemCount: transactions.length < 4 ? transactions.length : 3,
        itemBuilder: (BuildContext context, int index) {
          int revIndex = transactions.length - 1 - index;
          final transaction = transactions[revIndex];
          return buildRHistoryC(context, transaction);
        },
      );
    }
  }

  Widget buildRHistoryC(
    BuildContext context,
    Transaction transaction,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.source,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${DateFormat.yMMMd().format(transaction.date)}',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Text(
            '${transaction.amount}',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: transaction.isExpense ? Colors.red : Colors.green),
          ),
        ],
      ),
    );
  }
}
