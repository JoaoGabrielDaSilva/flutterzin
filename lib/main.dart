import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatefulWidget {
  @override
  _ExpensesAppState createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  ThemeData appTheme = ThemeData.dark();
  changeTheme() {
    setState(() {
      appTheme =
          appTheme == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
    });
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt-BR';
    initializeDateFormatting();
    return MaterialApp(
      home: MyHomePage(changeTheme),
      theme: appTheme.copyWith(
        buttonTheme: ButtonThemeData(
          buttonColor: appTheme.accentColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final void Function() changeTheme;
  MyHomePage(this.changeTheme);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = <Transaction>[];
  bool showGraph = true;

  _addTransaction(String title, double value, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date,
      ));
    });
    Navigator.pop(context);
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: TransactionForm(_addTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (e) => e.date.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BrunoDespesas'),
        actions: [
          if (MediaQuery.of(context).orientation == Orientation.landscape)
            IconButton(
              icon: Icon(showGraph ? Icons.list : Icons.bar_chart_rounded),
              onPressed: () => setState(() => showGraph = !showGraph),
            ),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: widget.changeTheme,
          ),
          if (MediaQuery.of(context).orientation == Orientation.landscape)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
        ],
      ),
      floatingActionButton:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _openTransactionFormModal(context),
                )
              : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (MediaQuery.of(context).orientation == Orientation.portrait ||
              showGraph)
            Expanded(
              child: Chart(_recentTransactions),
            ),
          if (MediaQuery.of(context).orientation == Orientation.portrait ||
              !showGraph)
            _transactions.isEmpty
                ? Expanded(
                    flex: 2,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 200,
                              child: Image.asset(
                                'assets/images/waiting.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Text(
                                'Não há transações!',
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 2,
                    child: TransactionList(_transactions, _removeTransaction),
                  ),
        ],
      ),
    );
  }
}
