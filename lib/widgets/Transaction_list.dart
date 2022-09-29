import 'package:apk/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class Transaction_List extends StatelessWidget {
  @override
  final List<Transaction> transactions;
  final Function deleteTx;

  Transaction_List(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {

    print("build of Transaction list");
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((ctx, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text("No Transaction is added!!!",
                  
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            );
          }))
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(transactions[index],deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
