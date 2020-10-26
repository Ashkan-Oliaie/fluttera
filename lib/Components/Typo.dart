import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';

class Typo extends StatefulWidget {


  Typo(
      {Key key,
        this.text,
        this.size:14,
        this.bold: false,
        this.color: Colors.black})
      : assert(text != null),
        super(key: key);

  String text;
  bool bold;
  Color color;
  int size;
  String body;

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Typo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.color,
              fontFamily: PersianFonts.Vazir.fontFamily,
              fontSize: widget.size.toDouble(),
              fontWeight: widget.bold ? FontWeight.bold : null),
        ));
  }
}