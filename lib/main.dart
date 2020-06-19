import 'package:bmma/Settings.dart';
import 'package:bmma/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMMA',
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmmaApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BmmaApp extends StatefulWidget {
  @override
  _BmmaAppState createState() => _BmmaAppState();
}

class _BmmaAppState extends State<BmmaApp> {
  var screens = [
    HomeScreen(),
    Settings(),
  ]; //screens for each tab

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B M M A', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 128, 128, 1),
      ),
     backgroundColor: Colors.white,
      body: screens[selectedTab],
    );
  }
}
