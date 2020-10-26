import 'package:flutter/material.dart';
import 'package:testapp/Components/Typo.dart';


class Touchable extends StatefulWidget {

  Touchable({Key key, this.onPress:null,this.height:45, this.caption:'Caption', this.color:Colors.blueGrey})
      : assert(caption != null),
        super(key: key);

  var onPress;
  String caption;
  Color color;
  double height;

  @override
  _TouchableState createState() => _TouchableState();
}

class _TouchableState extends State<Touchable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      margin: EdgeInsets.only(bottom:10,left: 20, right: 20),
      child: RaisedButton(
          elevation: 6,
          color: widget.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(11))),
          onPressed: widget.onPress,
          child: Typo(text:widget.caption,size: 18,)),
    );
  }
}