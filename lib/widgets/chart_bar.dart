import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    @required this.label,
    @required this.percentage,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 18,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: FittedBox(
              child: Text(
                value.toStringAsFixed(2),
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          label,
          style: Theme.of(context).primaryTextTheme.bodyText2,
        ),
      ],
    );
  }
}
