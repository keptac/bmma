import 'package:bmma/CurrencyConvertor.dart';
import 'package:bmma/ExchangeRate.dart';
import 'package:bmma/ProfitCalculator.dart';
import 'package:bmma/inventory/adminhome.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  HomeScreen({Key key, this.child}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.9),
                  Color.fromRGBO(0, 128, 128, 0.71)
                ],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(0, 6),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      "TODAY'S AVERAGE RATE",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          // fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Color.fromRGBO(0, 128, 128, 1)),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "USD | ZWL - 83.50",
                      style: TextStyle(
                        color: Color.fromRGBO(160, 82, 45, 1),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10.0,
                      left: 0.0,
                      child: SizedBox(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.03),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 85.0,
                      right: 40.0,
                      child: SizedBox(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: new BoxDecoration(
                            color: Colors.pink[800],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ListTile(
                              subtitle: Text(
                                'Daily Rates',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ExchangeRate(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 150.0,
                      right: 20.0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(0, 128, 128, 1),
                          shape: BoxShape.circle,
                        ),
                        // elevation: 10,
                        child: Center(
                          child: ListTile(
                            subtitle: Text(
                              'SP Calculator',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProfitCalculator(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 242.0,
                      right: 158.0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ListTile(
                            subtitle: Text(
                              'Manage Inventory',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 128, 128, 1),
                                  fontSize: 20.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Admin(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 90.0,
                      right: 160.0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          color: Colors.blue[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ListTile(
                            subtitle: Text(
                              'Financial Advice',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 128, 128, 1),
                                  fontSize: 20.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CurrencyConvertor(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
