import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet/Box/Boxes.dart';
import 'package:wallet/model/transactionclass.dart';
import 'package:wallet/pages/detailpage.dart';
import 'package:wallet/pages/historypage.dart';
import 'package:wallet/pages/inputpage.dart';
import 'package:wallet/pages/lenhistorypage.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0.0,
        title: const Text(
          'My Wallet',
        ),
        centerTitle: true,
      ),
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
    final tab = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.isTicked
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );

    final todayExp = transactions.fold<double>(
      0,
      (previousValue, transaction) =>
          transaction.date.day == DateTime.now().day &&
                  transaction.date.month == DateTime.now().month
              ? transaction.isExpense
                  ? previousValue + transaction.amount
                  : previousValue + 0
              : previousValue + 0,
    );
    final todayInc = transactions.fold<double>(
      0,
      (previousValue, transaction) =>
          transaction.date.day == DateTime.now().day &&
                  transaction.date.month == DateTime.now().month
              ? transaction.isExpense
                  ? previousValue + 0
                  : previousValue + transaction.amount
              : previousValue + 0,
    );

    final walletString = NumberFormat('##,##,##0').format(wallet);
    final bankString = NumberFormat('##,##,##0').format(bank);
    final moTab = tab < 0 ? -tab : tab;
    final tabString = NumberFormat('##,##,##0').format(moTab);
    final color = tab < 0 ? Colors.red : Colors.green;
    final todayExpStr = NumberFormat('##,##,##0').format(todayExp);
    final todayIncStr = NumberFormat('##,##,##0').format(todayInc);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DetailedPage()),
          );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSBox(fAmount: walletString, bName: "Wallet"),
              buildSBox(fAmount: bankString, bName: "Bank"),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LendHistoryPage()),
          );
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            child: Center(
              child: Text(
                '₹ $tabString',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
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
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    Text('₹ $todayExpStr',
                        style: const TextStyle(
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
        const SizedBox(
          height: 9,
        ),
        Expanded(
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HistoryPage()),
          );
              },
              child: Container(
                      width: MediaQuery.of(context).size.width - 20,
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
                    ),
            )),
        const SizedBox(
          height: 17,
        )
      ],
    );
  }


  Widget buildRHistory(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No History',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: transactions.length < 6 ? transactions.length : 6,
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
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat.yMMMd().format(transaction.date),
                style: const TextStyle(color: Colors.white70),
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

  Widget buildSBox({required String fAmount, required String bName}) {
    // First Box
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
          Text(
            '₹ $fAmount',
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            bName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          )
        ],
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
      String notes,
      double lendTotal) async {
    final transaction = Transaction()
      ..amount = amount
      ..isExpense = isExpense
      ..date = date
      ..category = category
      ..source = source
      ..isTicked = isTicked
      ..balance = balance
      ..notes = notes
      ..lendTotal = lendTotal;

    final box = Boxes.getTransactions();
    box.add(transaction);
  }
}
