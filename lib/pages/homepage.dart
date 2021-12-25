import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/pages/historypage.dart';
import 'package:wallet/pages/inputpage.dart';
import 'package:wallet/pages/lenthis.dart';
import 'package:wallet/pages/wallet.dart';
import 'package:wallet/model/transclass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/Boxes/boxes.dart';
import 'package:intl/intl.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

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
          backgroundColor: Color(0x0),
          elevation: 0.0,
          title: Text('My Wallet'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.history,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
              ),
            ]
        ),

        body: SafeArea(
          child: ValueListenableBuilder<Box<Transaction>>(
            valueListenable: Boxes.getTransactions().listenable(),
            builder: (context, box, _) {
              final transactions = box.values.toList().cast<Transaction>();
              return buildContent(transactions);
            },
          ),
        ),


        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffffdfaf),
          splashColor: Color(0xfff1884e),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyInputPage(
                    onClickedDone: addTransaction
                )),
            );
          },
          child: Icon(Icons.add,color: Color(0xfff1884e)),
        ),
      ),
    );
  }

  Future addTransaction(double amount, bool isExpense, DateTime dateSel, String drpcat, String drptf, String notes) async {
    final transaction = Transaction()
      ..amount = amount
      ..isExpense = isExpense
      ..createdDate = dateSel
      ..cate = drpcat
      ..tf = drptf
      ..notes = notes;

    final box = Boxes.getTransactions();
    box.add(transaction);
  }


  Widget buildContent(List<Transaction> transactions) {
      int day = DateTime.now().day;
      int month = DateTime.now().month;
      int year = DateTime.now().year;

      final netBalance = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Lend'
            ? previousValue + 0
            : transaction.isExpense
              ? previousValue - transaction.amount
              : previousValue + transaction.amount,
      );

      final netAvail = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.isExpense
          ? previousValue - transaction.amount
          : previousValue + transaction.amount,
      );

      final netWallet = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.tf == 'Wallet'
            ? transaction.isExpense
                ? previousValue - transaction.amount
                : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netBank = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.tf == 'Bank'
            ? transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netSWallet = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.tf == 'Sec. Wallet'
            ? transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netOthBank = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.tf == 'Other Banks'
            ? transaction.isExpense
                ? previousValue - transaction.amount
                : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netOther = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.tf == 'Others'
            ? transaction.isExpense
                ? previousValue - transaction.amount
                : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netLoan = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Lend'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue - transaction.amount
            : previousValue + 0,
      );

      final netExDay = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.createdDate.day == day &&
                transaction.createdDate.month == month &&
                transaction.createdDate.year == year &&
                transaction.cate != 'Lend' && transaction.cate != 'Transfer'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netExMonth = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.createdDate.month == month &&
                transaction.createdDate.year == year &&
                transaction.cate != 'Lend' && transaction.cate != 'Transfer'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netExyear = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.createdDate.year == year &&
                transaction.cate != 'Lend' && transaction.cate != 'Transfer'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netIncome = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate != 'Lend' &&
                transaction.cate != 'Transfer'
            ? transaction.isExpense
            ? previousValue + 0
            : previousValue + transaction.amount
            : previousValue + 0,
      );

      final netExpense= transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate != 'Lend' &&
                transaction.cate != 'Transfer'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netMisc = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Others'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netElectro = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Electronics'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netPC = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'PC Related'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netShop = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Shopping'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netEnter = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Entertainment'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final netRecha = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.cate == 'Recharge'
            ? transaction.isExpense
            ? previousValue + transaction.amount
            : previousValue + 0
            : previousValue + 0,
      );

      final newBal = NumberFormat('##,##,##0').format(netBalance);
      final newAvailBal = NumberFormat('##,##,##0').format(netAvail);
      final newWal = NumberFormat('##,##,##0').format(netWallet);
      final newBank = NumberFormat('##,##,##0').format(netBank);
      final newSWallet = NumberFormat('##,##,##0').format(netSWallet);
      final newOthBank = NumberFormat('##,##,##0').format(netOthBank);
      final newOther = NumberFormat('##,##,##0').format(netOther);
      final neLoan = netLoan<0 ? 0-netLoan : netLoan;
      final newLoan = NumberFormat('##,##,##0').format(neLoan);
      final newExDay = NumberFormat('##,##,##0').format(netExDay);
      final newExMonth = NumberFormat('##,##,##0').format(netExMonth);
      final newExYear = NumberFormat('##,##,##0').format(netExyear);
      final newNetIncome = NumberFormat('##,##,##0').format(netIncome);
      final newNetExpense = NumberFormat('##,##,##0').format(netExpense);
      final newMisc = NumberFormat('##,##,##0').format(netMisc);
      final newElectro = NumberFormat('##,##,##0').format(netElectro);
      final newPC = NumberFormat('##,##,##0').format(netPC);
      final newShop = NumberFormat('##,##,##0').format(netShop);
      final newEnter = NumberFormat('##,##,##0').format(netEnter);
      final newRecha = NumberFormat('##,##,##0').format(netRecha);
      final netam = netIncome - netExpense ;
      final color = netam<0 ? Colors.red : Colors.green ;
      final netamt = netam<0 ? 0-netam : netam;
      final newam = NumberFormat('##,##,##0').format(netamt);

      return Column(children: <Widget>[
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              padding: const EdgeInsets.only(left: 10,right: 10),
              children: <Widget>[
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('₹ $newBal',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold),),
                          SizedBox(height: 4,),
                          Text('Total Balance',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500, height: 17,
                            thickness: 2, indent: 40, endIndent: 40,),
                          Text('Balance : ₹ $newAvailBal',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),)
                        ],),
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
                          ),
                        ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Text('₹ $newWal',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 65,right: 65),
                                    child: Text('Wallet',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],),
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
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WalletPage()),
                              );
                            },
                            onDoubleTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyInputPage(
                                    typeo: 'Wallet',
                                    onClickedDone: addTransaction
                                )),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Text('₹ $newBank',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50,right: 50),
                                    child: Text('SIB Bank',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.0,1.0],
                                    colors: [
                                      Color(0xcc1d2671),
                                      Color(0xccc33764),
                                    ],
                                  )),
                            ),
                            onDoubleTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyInputPage(
                                    typeo: 'Bank',
                                    onClickedDone: addTransaction
                                )),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Text('₹ $newSWallet',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 43,right: 43),
                                    child: Text('Sec. Wallet',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],),
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
                            ),
                            onDoubleTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyInputPage(
                                    typeo: 'Sec. Wallet',
                                    onClickedDone: addTransaction
                                )),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Text('₹ $newOthBank',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 37,right: 37),
                                    child: Text('Other banks',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.0,1.0],
                                    colors: [
                                      Color(0xcc1d2671),
                                      Color(0xccc33764),
                                    ],
                                  )),
                            ),
                            onDoubleTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyInputPage(
                                    typeo: 'Other Banks',
                                    onClickedDone: addTransaction
                                )),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Text('₹ $newOther',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 61,right: 61),
                                    child: Text('Others',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],),
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
                            ),
                            onDoubleTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyInputPage(
                                    typeo: 'Others',
                                    onClickedDone: addTransaction
                                )),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0x10ffffff)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.arrow_downward_rounded,size: 40,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('Income',
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight.bold),),
                                                Text('$newNetIncome',
                                                  style: TextStyle(fontSize: 20,
                                                      fontWeight: FontWeight.bold),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(18))
                                ),
                                Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.arrow_upward_rounded,size: 40,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('Expense',
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight.bold),),
                                                Text('$newNetExpense',
                                                  style: TextStyle(fontSize: 20,
                                                      fontWeight: FontWeight.bold),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(18))
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10 , right: 10),
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text('$newam',
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold),)),
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(18))
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.0,1.0],
                          colors: [
                            Color(0x60ff8235),
                            Color(0x6030e8bf),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Daily Expenses : ₹ $newExDay',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500, height: 20,
                            thickness: 2, indent: 30, endIndent: 30,),
                          Text('Monthly Expenses : ₹ $newExMonth',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500, height: 20,
                            thickness: 2, indent: 30, endIndent: 30,),
                          Text('Yearly Expenses : ₹ $newExYear',
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Lend',
                                style: TextStyle(fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            Divider(color: Colors.grey.shade500,
                              height: 20, thickness: 2, indent: 40, endIndent: 40,),
                            Text('₹ $newLoan',
                                style: TextStyle(fontSize: 17,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.0,1.0],
                            colors: [
                              Color(0x90155799),
                              Color(0x90159957),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LentPage()),
                        );
                      },
                    ),
                    SizedBox(height: 15,),
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Others : ₹ $newMisc',
                            style: TextStyle(fontSize: 17,
                                fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500,
                            height: 20, thickness: 2, indent: 30, endIndent: 30,),
                          Text('Electronics : ₹ $newElectro',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500,
                            height: 20, thickness: 2, indent: 30, endIndent: 30,),
                          Text('PC Related : ₹ $newPC',
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Divider(color: Colors.grey.shade500,
                            height: 20, thickness: 2, indent: 30, endIndent: 30,),
                          Text('Shopping : ₹ $newShop',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500,
                            height: 20, thickness: 2, indent: 30, endIndent: 30,),
                          Text('Entertainment : ₹ $newEnter',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          Divider(color: Colors.grey.shade500,
                            height: 20, thickness: 2, indent: 30, endIndent: 30,),
                          Text('Recharge : ₹ $newRecha',
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.0,1.0],
                          colors: [
                            Color(0x60ff8235),
                            Color(0x6030e8bf),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                )
              ],
            ),
          ),
        )
      ],);
    
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}