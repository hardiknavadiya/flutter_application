// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/input_transaction.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/list_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Cal',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Transaction> transactions = [];
  bool _switchChart = false;

  void addTransaction(String tName, double tAmount, DateTime date) {
    setState(() {
      transactions
          .add(Transaction(DateTime.now().toString(), tName, tAmount, date));
    });
  }

  void openInputpopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (bctx) {
          return GestureDetector(
            onTap: () => print("onTap clicked"),
            behavior: HitTestBehavior.opaque,
            child: InputTransaction(addTransaction),
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void toggleSwitchChart(bool val) {
    setState(() {
      _switchChart = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text("Expense Calculator"),
    );
    final allTransaction = Container(
      child: const FittedBox(
        child: Text(
          "All Transactions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        appBar: appBar,
        body: !landscape
            ? Column(
                children: [
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top -
                              25) *
                          0.3,
                      child: Chart(transactions)),
                  allTransaction,
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top -
                              25) *
                          0.7,
                      child: ListTransaction(transactions, deleteTransaction)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Show Chart", style: TextStyle(fontSize: 15)),
                      if (landscape)
                        Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
                            value: _switchChart,
                            onChanged: (val) => toggleSwitchChart(val)),
                    ],
                  ),
                  _switchChart
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top -
                                  15) *
                              0.8,
                          child: Chart(transactions))
                      : Column(
                          children: [
                            allTransaction,
                            Container(
                                height: (MediaQuery.of(context).size.height -
                                        appBar.preferredSize.height -
                                        MediaQuery.of(context).padding.top -
                                        35) *
                                    0.8,
                                child: ListTransaction(
                                    transactions, deleteTransaction)),
                          ],
                        ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openInputpopup(context),
          child: const Icon(Icons.add),
        ));
  }
}
