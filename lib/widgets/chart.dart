import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
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
        'day': DateFormat.E(weekDay),
        'amount': totalAmount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
