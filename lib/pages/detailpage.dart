import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet/box/boxes.dart';
import 'package:wallet/model/transactionclass.dart';

class DetailedPage extends StatefulWidget {
  const DetailedPage({Key? key}) : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
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
    final tAmount = transactions.fold<double>(
      0,
      (previousValue, transaction) => !transaction.isTicked
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
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
    final home = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Home'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
    final amazonPay = transactions.fold<double>(
      0,
      (previousValue, transaction) => transaction.source == 'Amazon Pay'
          ? transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount
          : previousValue + 0,
    );
    final tAmountString = NumberFormat('##,##,##0').format(tAmount);
    final walletString = NumberFormat('##,##,##0').format(wallet);
    final bankString = NumberFormat('##,##,##0').format(bank);
    final homeString = NumberFormat('##,##,##0').format(home);
    final amazonPayString = NumberFormat('##,##,##0').format(amazonPay);
    return Column(
      children: [
        buildSBox(
            fAmount: tAmountString,
            bName: 'Total Amount',
            width: MediaQuery.of(context).size.width - 20),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSBox(
                fAmount: walletString,
                bName: 'Wallet',
                width: (MediaQuery.of(context).size.width - 30) / 2),
            buildSBox(
                fAmount: bankString,
                bName: 'Bank',
                width: (MediaQuery.of(context).size.width - 30) / 2),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSBox(
                fAmount: homeString,
                bName: 'Home',
                width: (MediaQuery.of(context).size.width - 30) / 2),
            buildSBox(
                fAmount: amazonPayString,
                bName: 'Amazon Pay',
                width: (MediaQuery.of(context).size.width - 30) / 2),
          ],
        )
      ],
    );
  }

  Widget buildSBox(
      {required String fAmount, required String bName, required double width}) {
    return Container(
      height: 80,
      width: width,
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
}
