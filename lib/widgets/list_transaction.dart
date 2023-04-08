import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ListTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;
  ListTransaction(this.transactions, this.deleteTransaction, {super.key});
  var availableColors = [Colors.red, Colors.amber, Colors.blue, Colors.black];

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
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 6,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundColor:
                                    availableColors[Random().nextInt(4)],
                                child: FittedBox(
                                  child: Text(transactions[index]
                                      .amount
                                      .toStringAsFixed(0)),
                                ),
                              ),
                              title: Text(
                                transactions[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(DateFormat.yMMMd()
                                  .format(transactions[index].date)),
                              trailing: IconButton(
                                  onPressed: () => deleteTransaction(
                                      transactions[index].id.toString()),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ));
                      })),
        ],
      );
    });
  }
}
