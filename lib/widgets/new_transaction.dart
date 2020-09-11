import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Reason for using this as a stateFull widget will be discussed later.
class NewTransaction extends StatefulWidget {
  final Function newTrHandler;

  NewTransaction(this.newTrHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitTransaction() {
    final title = _titleController.text;
    double amount;
    try {
      amount = double.parse(_amountController.text);
    } catch (e) {
      return;
    }

    if (title.isEmpty || amount <= 0 || _pickedDate == null) return;
    widget.newTrHandler(title, amount, _pickedDate);

    Navigator.of(context).pop();
  }

  void _showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        this._pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => this._submitTransaction(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => this._submitTransaction(),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'No date choosen!!!'
                            : DateFormat.yMd().format(_pickedDate),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatepicker,
                      child: Text(
                        'choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: this._submitTransaction,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).buttonColor,
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
