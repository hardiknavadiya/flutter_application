// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/input_transaction.dart';
import 'dart:io' show Platform;
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/list_transaction.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Cal',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, backgroundColor: Colors.white),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  List<Transaction> transactions = [
    Transaction(
      DateTime.now().toString(),
      "name",
      500,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      "name",
      500,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      "name",
      500,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      "name",
      500,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      "name",
      500,
      DateTime.now(),
    )
  ];
  bool _switchChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: const Text("Expense Calculator"),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
              ),
              onPressed: () => openInputpopup(context),
            ),
          )
        : AppBar(
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
    final pageBody = !landscape
        ? Column(
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          25) *
                      0.3,
                  child: Chart(transactions)),
              allTransaction,
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
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
          );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: SafeArea(child: pageBody),
          )
        : Scaffold(
            appBar: appBar,
            body: SafeArea(child: pageBody),
            floatingActionButton: FloatingActionButton(
              onPressed: () => openInputpopup(context),
              child: const Icon(Icons.add),
            ));
  }
}
