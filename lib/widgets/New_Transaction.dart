import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'dart:io';
import 'adaptive_flat_butoon.dart';



class NewTransaction extends StatefulWidget {
  Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _inputTitle = TextEditingController();

  final TextEditingController _inputPrice = TextEditingController();

  DateTime _selectedDate=DateTime.now() ;

  void _submitData() {
    if(_inputTitle.text==null)
    {
      return null;
    }


    final enterdTitle = _inputTitle.text;
    final enteredAmount = double.parse(_inputPrice.text);
    if (enterdTitle.isEmpty || enteredAmount < 0 || _selectedDate==null) {
      return;
    }

    widget.addTx(enterdTitle, enteredAmount,_selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
            right: 10,left: 10,bottom: (MediaQuery.of(context).viewInsets.bottom +10)
            ),
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: _inputTitle,
    
              // onChanged: (String val){
              //   _inputTitle=val;
    
              // },
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Price"),
              controller: _inputPrice,
              keyboardType: TextInputType.number,
              //  onChanged: (String val) {
              //   _inputPrice = val;
              // },
    
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'No date is chosen!'
                      : "Picked Date ${DateFormat.yMd().format(_selectedDate) as String}"),
                  AdaptiveFlatButton("Choose Date", _presentDatePicker)
                ],
              ),
            ),
            RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }
}
