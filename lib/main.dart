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
      home: WalletApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WalletApp extends StatefulWidget {
  @override
  _WalletAppState createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  var screens = [
    HomeScreen(),
    Settings(),
  ]; //screens for each tab

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B M M A'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Account")),
        ],
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        showUnselectedLabels: true,
        iconSize: 30,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   elevation: 0,
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[selectedTab],
    );
  }
}
