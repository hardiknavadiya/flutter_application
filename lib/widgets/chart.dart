import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/transaction.dart';
import 'package:flutter_application_2/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  List<Transaction> transactions;
  Chart(this.transactions, {super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get recentTransactionDate {
    var processedTransationsList = List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double tottalSumOfEachWeek = 0.0;
      var hour = DateFormat.H().format(DateTime.now());
      var minute = DateFormat.m().format(DateTime.now());

      for (int i = 0; i < widget.transactions.length; i++) {
        if (widget.transactions[i].date.isAfter(DateTime.now().subtract(
            Duration(
                days: 7,
                hours: int.parse(hour),
                minutes: int.parse(minute))))) {
          if (widget.transactions[i].date.year == weekDay.year &&
              widget.transactions[i].date.month == weekDay.month &&
              widget.transactions[i].date.day == weekDay.day) {
            tottalSumOfEachWeek += widget.transactions[i].amount;
          }
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": tottalSumOfEachWeek.toStringAsFixed(0),
      };
    });
    double maxValue = 0.0;
    for (Map<String, Object> transaction in processedTransationsList) {
      if (maxValue < double.parse(transaction["amount"].toString())) {
        maxValue = double.parse(transaction["amount"].toString());
      }
    }
    for (Map<String, Object> transaction in processedTransationsList) {
      double entireWeekSum = maxValue == 0.0
          ? 0.0
          : double.parse(transaction["amount"].toString()) / maxValue;
      transaction.putIfAbsent("proportion", () => entireWeekSum.toString());
    }
    return processedTransationsList;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...recentTransactionDate.reversed.map((chartDate) {
                return Flexible(fit: FlexFit.tight, child: ChartBar(chartDate));
              }).toList()
            ],
          ));
    });
  }
}
