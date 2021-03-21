import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) _removeTransaction;

  TransactionList(this.transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, i) {
        final t = transactions[i];
        return Card(
          elevation: 5,
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Container(
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                          child: Text(
                            'R\$${t.value.toStringAsFixed(2)}',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 3,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              t.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(DateFormat('dd MMM yyyy').format(t.date)),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () => _removeTransaction(t.id),
            ),
          ),
        );
      },
    );
  }
}
