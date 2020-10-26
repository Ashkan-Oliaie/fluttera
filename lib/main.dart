import 'package:flutter/material.dart';


import 'package:flutter_redux/flutter_redux.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:testapp/Screens/Navigator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testapp/Redux/Redux.dart';
import 'package:testapp/Hive/Hive.dart';
import 'package:load/load.dart';




void main() async {
  // var box = Hive.box('records');
  WidgetsFlutterBinding.ensureInitialized();
  Directory document=await getApplicationDocumentsDirectory();



  Hive.init(document.path);
  Hive.registerAdapter(HiveEntryAdapter());
  Hive.registerAdapter(HiveRecordAdapter());

  await Hive.openBox<HiveEntry>('records');



  runApp(
      LoadingProvider(
          themeData: LoadingThemeData(
            tapDismiss: false,
          ),
          child:MyApp() ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store:reduxStore,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: Nav.generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
