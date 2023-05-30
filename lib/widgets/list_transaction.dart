import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/transaction_item.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ListTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;
  ListTransaction(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(constraint.maxHeight * 0.01),
            height: constraint.maxHeight * 0.98,
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      "No Transaction Available",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                : ListView(
                    children: [
                      ...transactions
                          .map((tx) => TransactionIteam(tx, deleteTransaction,
                              key: ValueKey(tx.id)))
                          .toList()
                    ],
                  ),
          )
        ],
      );
    });
  }
}
