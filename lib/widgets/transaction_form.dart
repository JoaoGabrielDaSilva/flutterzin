import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _datePicked;

  bool _titleValid = true;
  bool _valueValid = true;
  bool _dateValid = true;

  _onSubmit() {
    setState(() {
      _titleValid = _titleController.text.isNotEmpty;
      _valueValid = (double.tryParse(_valueController.text) ?? 0) > 0;
      _dateValid = _datePicked != null;
    });
    if (_titleValid && _valueValid)
      widget.onSubmit(_titleController.text,
          double.tryParse(_valueController.text) ?? 0.0, _datePicked);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                labelText: 'Título',
                errorText: _titleValid ? null : 'Informe um título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onEditingComplete: _onSubmit,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
                errorText: _valueValid ? null : 'Informe um valor válido',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      _datePicked == null
                          ? 'Nenhuma data selecionada!'
                          : DateFormat('dd/MM/y').format(_datePicked),
                      style: TextStyle(
                        color: _dateValid ? null : Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 1),
                        lastDate: now,
                      ).then((date) {
                        _datePicked = date;
                        setState(() => _dateValid = true);
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text(
                      'Nova transação',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: _onSubmit,
                    textColor: Theme.of(context).dialogBackgroundColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
