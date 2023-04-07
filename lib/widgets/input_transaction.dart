import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class InputTransaction extends StatefulWidget {
  Function addTransaction;
  InputTransaction(this.addTransaction, {super.key});

  @override
  State<InputTransaction> createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final nameController = TextEditingController();

  final amuntController = TextEditingController();
  var dateController = TextEditingController();
  var datepickerDate;

  submitData() {
    print("inside input validation");
    if (nameController.text.isEmpty ||
        double.parse(amuntController.text).isNegative ||
        dateController.text.isEmpty) {
      return;
    }
    widget.addTransaction(nameController.text,
        double.parse(amuntController.text), datepickerDate);
    Navigator.pop(context);
  }

  void showDatePickerOnClick() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      datepickerDate = pickedDate;
      setState(() {
        dateController.text = DateFormat.yMMMd().format(pickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 15),
            width: double.infinity,
            child: Column(children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amuntController,
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                ),
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
              ),
              TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                  ),
                  readOnly: true,
                  onTap: showDatePickerOnClick),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: () => submitData(),
                      child: const Text("Add Expense"))
                  : ElevatedButton(
                      onPressed: () => submitData(),
                      child: const Text("Add Expense"))
            ])),
      ),
    );
  }
}
