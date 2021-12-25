import 'package:flutter/material.dart';
import 'package:wallet/model/transclass.dart';
import 'package:intl/intl.dart';

class MyInputPage extends StatefulWidget {
  final Transaction? transaction;
  final String? typeo;
  final Function(double amount, bool isExpense, DateTime dateSel, String drpcat, String drptf, String notes) onClickedDone;


  const MyInputPage({
    Key? key,
    this.typeo,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);


  @override
  _MyInputPageState createState() => _MyInputPageState();
}

class _MyInputPageState extends State<MyInputPage> {
  String drpcat = 'Others';
  String drptf = 'Wallet';
  bool isExpense = true;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final tofrmController = TextEditingController();
  final notesController = TextEditingController();

  DateTime dateSel = DateTime.now();

  String getText() {
    return DateFormat.yMMMd().format(dateSel).toString();
  }

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      amountController.text = transaction.amount.toString();
      isExpense = transaction.isExpense;
      dateSel = transaction.createdDate;
      drpcat = transaction.cate;
      drptf = transaction.tf;
      notesController.text = transaction.notes;
    }
    if(widget.typeo != null) {
      drptf = widget.typeo!;
    }
  }

  @override
  void dispose() {
    tofrmController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';
    final text = isEditing ? 'Save' : 'Add';

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
            title: Text(title),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:10,left: 12, right: 12),
                      child: TextFormField(
                        maxLength: 7,
                        keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              counter: Offstage(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                borderRadius: new BorderRadius.circular(15.0)
                            ),
                            fillColor: Color(0xff0f2027),
                            filled: true,
                            prefixIcon: Icon(Icons.money,color: Colors.white),
                            contentPadding: EdgeInsets.all(10),
                            hintText: ' Amount',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                          validator: (amount) => amount != null && double.tryParse(amount) == null
                              ? 'Enter a valid number'
                              : null,
                          controller: amountController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:20,left: 12,right: 12,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.457,
                            child: RadioListTile<bool>(
                              activeColor: Colors.white,
                              title: Text('Debit',style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),),
                              value: true,
                              groupValue: isExpense,
                              onChanged: (value) => setState(() => isExpense = value!),
                            ),
                              decoration: BoxDecoration(
                                  color: Color(0xff0f2027),
                                  borderRadius: BorderRadius.circular(15))
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.457,
                            child: RadioListTile<bool>(
                              activeColor: Colors.white,
                              title: Text('Credit',style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),),
                              value: false,
                              groupValue: isExpense,
                              onChanged: (value) => setState(() => isExpense = value!),
                            ),
                              decoration: BoxDecoration(
                                  color: Color(0xff0f2027),
                                  borderRadius: BorderRadius.circular(15))
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          primary: Color(0xff0f2027),
                          onPrimary: Colors.white,
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))

                        ),
                        onPressed: () {
                          pickDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(getText(),style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 10),
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0,right: 4),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: drpcat,
                          icon: const Icon(Icons.arrow_drop_down_rounded,color: Colors.white),
                          iconSize: 40,
                          elevation: 16,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              drpcat = newValue!;
                            });
                          },
                          items: <String>['Others', 'Electronics', 'Lend','Shopping','Recharge','Travelling','Entertainment','PC Related','Transfer']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 4,bottom: 12),
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0,right: 4),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: drptf,
                          icon: Icon(Icons.arrow_drop_down_rounded,color: Colors.white),
                          iconSize: 40,
                          elevation: 16,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              drptf = newValue!;
                            });
                          },
                          items: <String>['Wallet','Bank','Sec. Wallet','Other Banks','Others']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12,top: 8,bottom: 12),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                borderRadius: new BorderRadius.circular(15.0)
                            ),
                            fillColor: Color(0xff0f2027),
                            filled: true,
                            prefixIcon: Icon(Icons.notes,color: Colors.white),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Notes',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                        controller: notesController,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.only(left: 100,right: 100),
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0f2027),
                          onPrimary: Colors.white,
                            minimumSize: Size(80, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();

                          if (isValid) {
                            final amount = double.tryParse(amountController.text) ?? 0;
                            final notes = notesController.text;

                            widget.onClickedDone(amount, isExpense, dateSel, drpcat, drptf, notes);

                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future pickDate(BuildContext context)async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5)
    );
    if(newDate == null) return;
    setState(() {
      dateSel = newDate;
    });
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}