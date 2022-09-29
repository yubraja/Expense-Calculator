import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';


class AdaptiveFlatButton extends StatelessWidget {

final String msg;
final VoidCallback handler;


AdaptiveFlatButton(this.msg,this.handler);


  @override
  Widget build(BuildContext context) {

    print("Build of adaptive_flat_button");
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
        : TextButton(
            onPressed: handler,
            child: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
    
  }
}