import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';


void Flash(BuildContext context,Widget text,Color color){
  Flushbar(

    duration: Duration(seconds: 1),
    backgroundColor: color,
    messageText:text,

  )..show(context);


}