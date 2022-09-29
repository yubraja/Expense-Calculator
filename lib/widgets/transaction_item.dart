import 'package:flutter/material.dart';

import '../models/Transaction.dart';

import 'package:intl/intl.dart';







class TransactionItem extends StatelessWidget {

Transaction transactions;
Function _deleteTransaction;

  TransactionItem(this.transactions,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child:
                  FittedBox(child: Text("Rs ${transactions.amount}"))),
        ),
        title: Text(
          transactions.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(DateFormat.yMMMd().format(transactions.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () => {_deleteTransaction(transactions.id)},
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () => {_deleteTransaction(transactions.id)},
                icon: const Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
    
  }
}