import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet/globalvar.dart';
import 'package:wallet/model/transactionclass.dart';

class InputPage extends StatefulWidget {
  final Transaction? transaction;
  final Function(double amount, bool isExpense, DateTime date, String category,
      String source, bool isTicked, double balance, String notes) onClickedDone;

  const InputPage({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
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
                  decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 16, top: 75, right: 18),
                      hintText: "Amount",
                      hintStyle: TextStyle(color: Colors.white70)),
                  style: TextStyle(fontSize: 50, color: Colors.white70),
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
                          child: Center(
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
                          child: Center(
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
                              style: TextStyle(
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
                              underline: SizedBox(),
                              style: TextStyle(
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
                              underline: SizedBox(),
                              style: TextStyle(
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
                                ? Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  )
                                : Icon(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text('Advanced options',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          isExpanded
                              ? Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white70,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                isExpanded ? buildAdvOptions() : SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    controller: notesController,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: new BorderRadius.circular(20.0)),
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: "Notes",
                        prefixIcon: Icon(Icons.notes, color: Colors.white70),
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(color: Colors.white70)),
                    style: TextStyle(color: Colors.white70),
                    cursorColor: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(120, 50)),
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
                        final double balance = isEditing || isTransfer
                            ? 0
                            : isExpense
                                ? Balance.totalbalance - amount
                                : Balance.totalbalance + amount;

                        widget.onClickedDone(amount, isExpense, date, category,
                            source, isTicked, balance, notes);
                        if (isExpanded) {
                          if (isMultiple) {
                            final amount2 =
                                double.tryParse(amount2Controller.text) ?? 0;
                            final double balance2 = isEditing
                                ? 0
                                : isExpense
                                    ? Balance.totalbalance - amount - amount2
                                    : Balance.totalbalance + amount + amount2;
                            widget.onClickedDone(
                                amount2,
                                isExpense,
                                date,
                                category,
                                dropdownmvalue,
                                isTicked,
                                balance2,
                                notes);
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
                                notes);
                          }
                        }

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(buttonText,
                        style: TextStyle(
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
                        ? Icon(
                            Icons.check_box,
                            color: Colors.blue,
                          )
                        : Icon(
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
        isMultiple ? buildMultiOpt() : SizedBox(),
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
                        ? Icon(
                            Icons.check_box,
                            color: Colors.blue,
                          )
                        : Icon(
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
                    underline: SizedBox(),
                    style: TextStyle(
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
            : SizedBox(),
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
              decoration: new InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: new BorderRadius.circular(20.0)),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: "Amount",
                  prefixIcon: Icon(Icons.money, color: Colors.white70),
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(color: Colors.white70)),
              style: TextStyle(color: Colors.white70),
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
                underline: SizedBox(),
                style: TextStyle(
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
