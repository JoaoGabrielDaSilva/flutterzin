import 'package:expenses/widgets/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (i) {
      double sum = 0;
      final weekDay = DateTime.now().subtract(Duration(days: i));

      recentTransactions.forEach((a) {
        if (a.date.day == weekDay.day &&
            a.date.month == weekDay.month &&
            a.date.year == weekDay.year) sum += a.value;
      });

      return {
        'day': DateFormat.E().format(weekDay)[0].toUpperCase(),
        'value': sum
      };
    }).reversed.toList();
  }

  double get _sumOfWeek =>
      groupedTransactions.fold(0.0, (sum, e) => sum + e['value']);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 8,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 9),
              child: Text(
                'Transações dos últimos 7 dias',
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: groupedTransactions
                      .map(
                        (e) => Expanded(
                          child: ChartBar(
                            label: e['day'],
                            percentage: _sumOfWeek == 0
                                ? 0.0
                                : (e['value'] as double) / _sumOfWeek,
                            value: e['value'],
                          ),
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
