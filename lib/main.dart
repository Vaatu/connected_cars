import 'package:connectedcar/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  SyncfusionLicense.registerLicense("NT8mJyc2IWhia31ifWN9ZmFoZHxiY3xhY2Fjc2JjaWdmaWFqcwMeaD42NzwgIzo3NiFiY2VjEzQ+Mjo/fTA8Pg==");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connected Car',
      theme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          primaryColor: Color(0xFF0A0E21)),
      home: MyHomePage(title: 'Connected Car'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: HomeScreen()
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
