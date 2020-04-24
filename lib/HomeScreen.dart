import 'package:bmma/ExchangeRate.dart';
import 'package:bmma/ProfitCalculator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  HomeScreen({Key key, this.child}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Today's Average Rate",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blue[100]),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            color: Colors.lightBlue[100],
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue[900],
                            child: ClipOval(
                              child: Image.asset(
                                "assets/dp.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "USD / ZWL - 34.5",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExchangeRate(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue[900],
                                size: 30,
                              ),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Rates",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.blue[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfitCalculator(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: Icon(
                                Icons.public,
                                color: Colors.blue[900],
                                size: 30,
                              ),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Profit Calculator",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.blue[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfitCalculator(),
                                ),
                              )
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: Icon(
                                Icons.attach_money,
                                color: Colors.blue[900],
                                size: 30,
                              ),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "My Inventory",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.blue[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
