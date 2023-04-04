import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  Map<String, Object> chartDate;
  ChartBar(this.chartDate, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                chartDate["amount"].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.65,
            width: 25,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    color: Colors.grey[200],
                  ),
                ),
                FractionallySizedBox(
                  heightFactor:
                      double.parse(chartDate["proportion"].toString()),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(child: Text(chartDate["day"].toString()))),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          )
        ],
      );
    });
  }
}
