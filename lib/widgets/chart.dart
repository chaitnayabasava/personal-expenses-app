import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chat_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      recentTransactions.forEach((tr) {
        if (tr.date.day == weekDay.day &&
            tr.date.month == weekDay.month &&
            tr.date.year == weekDay.year) {
          totalAmount += tr.amount;
        }
      });
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get maxAmount {
    return groupedTransactions.fold(
      0,
      (previousValue, element) => previousValue + element['amount'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tr['day'],
                tr['amount'],
                maxAmount == 0 ? 0.0 : (tr['amount'] as double) / maxAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
