import 'package:flutter/material.dart';
import 'package:testapp/Screens/AddRecord.dart';
import 'package:testapp/Screens/HomeScreen.dart';



class Nav{
  static Route generateRoute(RouteSettings settings){
    final params = settings.arguments;

    Map args=params;

    switch(settings.name){
    // case '/authRegister':
    //   return MaterialPageRoute(builder:(_)=>AuthRegister());

      case '/':
        return MaterialPageRoute(builder:(_)=>HomeScreen());
      case '/addRecord':
        return MaterialPageRoute(builder:(_)=>AddRecord());



      default:
        return ErrorPage();
    }
  }

  static Route ErrorPage(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
        appBar: AppBar(
          title:Text('appbar'),
        ),
        body:Text('Something went wrong')
    ));
  }

}