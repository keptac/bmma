import 'package:flutter/material.dart';

class ExchangeRate extends StatefulWidget {
  @override
  _ExchangeRateState createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<ExchangeRate> {
  final _zwlController = TextEditingController();
  final _usdController = TextEditingController();
  double _result = 0.0;
  double _currentRate = 34.5;
  double _zwlVal = 0.0;
  double _usdValue = 0.0;
  bool _zwlEnable = true;
  bool _usdEnable = true;
  var rates = [52, 39.5, 38.7, 38.5, 18.26, 28.8];
  // var rates = [
  //   {'source': 'zimrates', 'rate': 52},
  //   {'source': 'zimrates', 'rate': 39.5},
  //   {'source': 'zimrates', 'rate': 38.7},
  //   {'source': 'zimrates', 'rate': 38.5},
  //   {'source': 'rbz.co.zw', 'rate': 18.26},
  //   {'source': 'bond', 'rate': 28.8},
  // ];

  void _clear() {
    setState(() {
      _zwlController.clear();
      _usdController.clear();
      _zwlEnable = true;
      _usdEnable = true;
      _result = 0.0;
    });
  }

  void _currencyConvertor() {
    setState(() {
      if (_zwlController.text.isNotEmpty && _usdController.text.isEmpty) {
        _zwlVal = double.parse(_zwlController.text);
        _result = _zwlVal / _currentRate;
      } else if (_usdController.text.isNotEmpty &&
          _zwlController.text.isEmpty) {
        _usdValue = double.parse(_usdController.text);
        _result = _usdValue * _currentRate;
      } else {
        print("Error");
      }
    });
  }

  void _disableZwl() {
    setState(() {
      _zwlEnable = false;
    });
  }

  void _disableUsd() {
    setState(() {
      _usdEnable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('BMMA Rates'),
          centerTitle: true,
        ),
        backgroundColor: Color.fromRGBO(38, 81, 158, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Container(
                  child: Center(
                    child: Text('Exchange Rates',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 245, 248, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            child: Text(
                              "TODAY",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[500]),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 32),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: 32, left: 32, bottom: 10),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18))),
                                        child: Icon(
                                          Icons.date_range,
                                          color: Colors.lightBlue[900],
                                        ),
                                        padding: EdgeInsets.all(10),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "USD/ZWL\$",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[900]),
                                            ),
                                            Text(
                                              "zimrates.com",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[500]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "\$ " + rates[index].toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: rates.length,
                              padding: EdgeInsets.all(0),
                              controller:
                                  ScrollController(keepScrollOffset: false),
                            ),
                          ),
                          Divider(
                            thickness: 10,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20, bottom: 10),
                                  child: Text(
                                    '$_result',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 60,
                                        width: 180,
                                        child: TextField(
                                          controller: _usdController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.attach_money,
                                              color: Colors.blue[900],
                                              size: 20,
                                            ),
                                            labelText: 'USD',
                                            labelStyle: TextStyle(
                                                color: Colors.blue[900]),
                                            enabledBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: new BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: new BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                          ),
                                          onTap: _disableZwl,
                                          enabled: _usdEnable,
                                          onEditingComplete: _currencyConvertor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      SizedBox(
                                        height: 60,
                                        width: 180,
                                        child: TextField(
                                          controller: _zwlController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.attach_money,
                                              color: Colors.blue[900],
                                              size: 20,
                                            ),
                                            labelText: 'ZWL',
                                            labelStyle: TextStyle(
                                                color: Colors.blue[900]),
                                            enabledBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: new BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: new BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                          ),
                                          enabled: _zwlEnable,
                                          onEditingComplete: _currencyConvertor,
                                          onTap: _disableUsd,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 100.0),
                                      child: RaisedButton(
                                        onPressed: _currencyConvertor,
                                        color: Colors.blue[900],
                                        child: Text(
                                          "Calculate",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: RaisedButton(
                                        onPressed: _clear,
                                        color: Colors.red,
                                        child: Text(
                                          "Clear",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      controller: scrollController,
                    ),
                  );
                },
                initialChildSize: 0.80,
                minChildSize: 0.80,
                maxChildSize: 0.80,
              )
            ],
          ),
        ));
  }
}
