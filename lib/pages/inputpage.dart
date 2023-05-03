import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet/box/boxes.dart';
import 'package:wallet/model/transactionclass.dart';

class InputPage extends StatefulWidget {
  final Transaction? transaction;
  final Function(
      double amount,
      bool isExpense,
      DateTime date,
      String category,
      String source,
      bool isTicked,
      double balance,
      String notes,
      double lendTotal) onClickedDone;

  const InputPage({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final transactions =
      Boxes.getTransactions().values.toList().cast<Transaction>();
  Color colorcr = Colors.grey.shade900;
  Color colorde = Colors.blue;
  bool isExpense = true;
  bool isTicked = false;
  bool isExpanded = false;
  bool isMultiple = false;
  bool isTransfer = false;
  String dropdownmvalue = 'Amazon Pay';
  String dropdowntvalue = 'Wallet';

  String category = 'Others';

  var items1 = ['Others', 'Travel', 'College', 'Electronics', 'Food'];
  String source = 'Wallet';

  var items2 = ['Wallet', 'Bank', 'Home', 'Amazon Pay'];

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final amount2Controller = TextEditingController();
  late double balance;
  late double lendTotal;

  DateTime date = DateTime.now();

  String getText() {
    return DateFormat.yMMMd().format(date).toString();
  }

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      amountController.text = transaction.amount.toString();
      isExpense = transaction.isExpense;
      date = transaction.date;
      category = transaction.category;
      source = transaction.source;
      isTicked = transaction.isTicked;
      notesController.text = transaction.notes;
      balance = transaction.balance;
      lendTotal = transaction.lendTotal;

      if (!isExpense) {
        colorcr = Colors.blue;
        colorde = Colors.grey.shade900;
      }
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';
    final buttonText = isEditing ? 'Save' : 'Add';

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0.0,
        title: Text(
          title,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (amount) =>
                      amount != null && double.tryParse(amount) == null
                          ? 'Enter a valid number'
                          : null,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 16, top: 75, right: 18),
                      hintText: "Amount",
                      hintStyle: const TextStyle(color: Colors.white70)),
                  style: const TextStyle(fontSize: 50, color: Colors.white70),
                  cursorColor: Colors.white70,
                  cursorHeight: 62,
                  textAlign: TextAlign.end,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            if (isExpense) {
                              isExpense = false;
                              colorcr = Colors.blue;
                              colorde = Colors.grey.shade900;
                            }
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Ink(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 24) / 2,
                          decoration: BoxDecoration(
                              color: colorcr,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text('Credit',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            if (!isExpense) {
                              isExpense = true;
                              colorde = Colors.blue;
                              colorcr = Colors.grey.shade900;
                            }
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Ink(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 24) / 2,
                          decoration: BoxDecoration(
                              color: colorde,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text('Debit',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 7),
                  child: InkWell(
                    onTap: () {
                      pickDate(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(getText(),
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70))),
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Ink(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 24) / 2,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                              elevation: 0,
                              // itemHeight: 24,
                              dropdownColor: Colors.grey.shade900,
                              value: category,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items1.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  category = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        Ink(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 24) / 2,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                              elevation: 0,
                              dropdownColor: Colors.grey.shade900,
                              value: source,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items2.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  source = newValue!;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )),

                // end of drop
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(17),
                      onTap: () {
                        setState(() {
                          isTicked = !isTicked;
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: SizedBox(
                        height: 45,
                        width: 150,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            isTicked
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.white70,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Add to Tab',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(17),
                    onTap: () {
                      setState(() {
                        if (isMultiple || isTransfer) {
                          isMultiple = false;
                          isTransfer = false;
                        }

                        isExpanded = !isExpanded;
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Advanced options',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          isExpanded
                              ? const Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white70,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                isExpanded ? buildAdvOptions() : const SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    controller: notesController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: "Notes",
                        prefixIcon:
                            const Icon(Icons.notes, color: Colors.white70),
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: const TextStyle(color: Colors.white70)),
                    style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(120, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        final amount =
                            double.tryParse(amountController.text) ?? 0;
                        final notes = notesController.text;

                        if (!isEditing) {
                          final pBalance = transactions.fold<double>(
                            0,
                            (previousValue, transaction) =>
                                !transaction.isTicked
                                    ? transaction.isExpense
                                        ? previousValue - transaction.amount
                                        : previousValue + transaction.amount
                                    : previousValue + 0,
                          );
                          balance = !isTicked
                              ? isExpense
                                  ? pBalance - amount
                                  : pBalance + amount
                              : pBalance;
                          final pLendTotal = transactions.fold<double>(
                            0,
                            (previousValue, transaction) => transaction.isTicked
                                ? transaction.isExpense
                                    ? previousValue - transaction.amount
                                    : previousValue + transaction.amount
                                : previousValue + 0,
                          );
                          lendTotal = isTicked
                              ? isExpense
                                  ? pLendTotal - amount
                                  : pLendTotal + amount
                              : pBalance;
                        }
                        widget.onClickedDone(amount, isExpense, date, category,
                            source, isTicked, balance, notes, lendTotal);
                        if (isExpanded) {
                          if (isMultiple) {
                            final amount2 =
                                double.tryParse(amount2Controller.text) ?? 0;

                            widget.onClickedDone(
                                amount2,
                                isExpense,
                                date,
                                category,
                                dropdownmvalue,
                                isTicked,
                                balance,
                                notes,
                                lendTotal);
                          }
                          if (isTransfer) {
                            widget.onClickedDone(
                                amount,
                                !isExpense,
                                date,
                                category,
                                dropdowntvalue,
                                isTicked,
                                balance,
                                notes,
                                lendTotal);
                          }
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(buttonText,
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAdvOptions() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(17),
              onTap: () {
                setState(() {
                  if (isTransfer) isTransfer = false;
                  isMultiple = !isMultiple;
                });
              },
              child: SizedBox(
                height: 50,
                width: (MediaQuery.of(context).size.width - 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    isMultiple
                        ? const Icon(
                            Icons.check_box,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.white70,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Payment from multiple Accounts',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
        isMultiple ? buildMultiOpt() : const SizedBox(),
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(17),
              onTap: () {
                setState(() {
                  if (isMultiple) isMultiple = false;
                  isTransfer = !isTransfer;
                });
              },
              child: SizedBox(
                height: 50,
                width: (MediaQuery.of(context).size.width - 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    isTransfer
                        ? const Icon(
                            Icons.check_box,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.white70,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Add Transfer',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
        isTransfer
            ? Ink(
                height: 50,
                width: (MediaQuery.of(context).size.width - 24),
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                    elevation: 0,
                    dropdownColor: Colors.grey.shade900,
                    value: dropdowntvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items2.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdowntvalue = newValue!;
                      });
                    },
                  ),
                ),
              )
            : const SizedBox(),
        const Divider(
          indent: 12,
          endIndent: 12,
          color: Colors.grey,
          thickness: 1.2,
        ),
      ],
    );
  }

  Widget buildMultiOpt() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
            width: (MediaQuery.of(context).size.width - 24) / 2,
            child: TextFormField(
              validator: (amount2) =>
                  amount2 != null && double.tryParse(amount2) == null
                      ? 'Enter a valid number'
                      : null,
              controller: amount2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0)),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: "Amount",
                  prefixIcon: const Icon(Icons.money, color: Colors.white70),
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle: const TextStyle(color: Colors.white70)),
              style: const TextStyle(color: Colors.white70),
              cursorColor: Colors.white70,
            ),
          ),
          Ink(
            height: 50,
            width: (MediaQuery.of(context).size.width - 24) / 2,
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DropdownButton(
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
                elevation: 0,
                dropdownColor: Colors.grey.shade900,
                value: dropdownmvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items2.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownmvalue = newValue!;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }
}
