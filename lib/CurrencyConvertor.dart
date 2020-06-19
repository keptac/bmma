import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class CurrencyConvertor extends StatefulWidget {
  @override
  _ExchangeRateState createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<CurrencyConvertor> {
  final _zwlController = TextEditingController();
  final _usdController = TextEditingController();
  double _result = 0.0;
  double _currentRate = 83.5;
  double _zwlVal = 0.0;
  double _usdValue = 0.0;
  bool _zwlEnable = true;
  bool _usdEnable = true;
  var rates = [85.20, 82.00, 25.00, 58.40];

  bool connected;

  _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connected = false;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        connected = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

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

  Widget convertorGeneric() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
                        color: Color.fromRGBO(0, 128, 128, 1),
                        size: 20,
                      ),
                      labelText: 'USD',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 128, 128, 1)),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        borderSide: new BorderSide(
                          color: Color.fromRGBO(0, 128, 128, 1),
                        ),
                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        borderSide: new BorderSide(
                          color: Color.fromRGBO(0, 128, 128, 1),
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
                        color: Color.fromRGBO(0, 128, 128, 1),
                        size: 20,
                      ),
                      labelText: 'ZWL',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 128, 128, 1)),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        borderSide: new BorderSide(
                          color: Color.fromRGBO(0, 128, 128, 1),
                        ),
                      ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        borderSide: new BorderSide(
                          color: Color.fromRGBO(0, 128, 128, 1),
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
          SizedBox(height: 25.0),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 100.0),
                child: RaisedButton(
                  onPressed: _currencyConvertor,
                  color: Color.fromRGBO(0, 128, 128, 1),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 128, 128, 1),
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
                    child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(0, 0, 50, 0.9),
                              Color.fromRGBO(0, 0, 50, 0.7),
                            ]),
                      ),
                    ),
                    Center(
                      child: Text(
                        DateFormat('yyyy-MM-dd – kk:mm')
                                .format(DateTime.now())
                                .toString() +
                            '\nCurrency Convetor Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
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
                          Divider(
                            thickness: 10,
                          ),
                          connected
                              ? Center(
                                  child: Text('Connected: Create Chat Screen'),
                                )
                              : convertorGeneric()
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
