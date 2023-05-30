import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionIteam extends StatefulWidget {
  Transaction transaction;
  Function deleteTransaction;

  TransactionIteam(this.transaction, this.deleteTransaction,
      {required ValueKey<String> key})
      : super(key: key);

  @override
  State<TransactionIteam> createState() => _TransactionIteamState();
}

class _TransactionIteamState extends State<TransactionIteam> {
  var bgColor;
  @override
  void initState() {
    print("init state called transaction item");
    var availableColors = [Colors.red, Colors.amber, Colors.blue, Colors.black];
    bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundColor: bgColor,
            child: FittedBox(
              child: Text(widget.transaction.amount.toStringAsFixed(0)),
            ),
          ),
          title: Text(
            widget.transaction.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
          trailing: IconButton(
              onPressed: () =>
                  widget.deleteTransaction(widget.transaction.id.toString()),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ));
  }
}
