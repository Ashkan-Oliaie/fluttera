import 'package:flutter/material.dart';


class Loada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Container(
            width: 100,
            height: 100,
            child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepPurple),)
        )
    );
  }
}
