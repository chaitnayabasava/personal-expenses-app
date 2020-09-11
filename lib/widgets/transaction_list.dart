import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  TransactionList(this.transactions, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, idx) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('${transactions[idx].amount}\u20B9'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[idx].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(transactions[idx].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteHandler(transactions[idx].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
