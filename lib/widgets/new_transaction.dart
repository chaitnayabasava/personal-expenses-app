import 'package:flutter/material.dart';

// Reason for using this as a stateFull widget will be discussed later.
class NewTransaction extends StatefulWidget {
  final Function newTrHandler;

  NewTransaction(this.newTrHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _submitTransaction() {
    final title = titleController.text;
    double amount;
    try {
      amount = double.parse(amountController.text);
    } catch (e) {
      return;
    }

    if (title.isEmpty || amount <= 0) return;
    widget.newTrHandler(
      title,
      amount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => this._submitTransaction(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => this._submitTransaction(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              onPressed: this._submitTransaction,
              textColor: Colors.purple,
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
