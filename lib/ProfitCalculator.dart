import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfitCalculator extends StatefulWidget {
  @override
  _ProfitCalculatorState createState() => _ProfitCalculatorState();
}

class _ProfitCalculatorState extends State<ProfitCalculator> {
  final _profitController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  double _profit = 0.0;
  double _costPrice = 0.0;
  double _sellingPrice = 0.0;
  double _sellingPriceUsd = 0.0;
  double _averageRate = 83.5;
  String currency = 'ZWL';
  int _quantity = 1;

  void _showResultDialog(currency, rate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SP Results'),
          content: Text(
              'Sell each item at ' + currency + ' ' + rate.toStringAsFixed(2)),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateSellingPrice() {
    if (_costPriceController.text.isNotEmpty &&
        _profitController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      _quantity = int.parse(_quantityController.text);
      if (_quantity == 0) {
        _quantity = 1;
      }

      _profit = double.parse(_profitController.text);
      _costPrice = double.parse(_costPriceController.text) / _quantity;
      _sellingPrice = (100 + _profit) * (_costPrice / 100);

      if (currency == "USD") {
        _showResultDialog(currency, _sellingPrice / _averageRate);
        setState(() {
          _sellingPriceUsd = _sellingPrice / _averageRate;
        });
      } else if (currency == "ZWL") {
        _sellingPriceUsd = _sellingPrice;
        _showResultDialog(currency, _sellingPriceUsd * _averageRate);
        setState(() {
          _sellingPrice = _sellingPriceUsd * _averageRate;
        });
      }
    } else {}
  }

  void _clear() {
    setState(() {
      _profitController.clear();
      _costPriceController.clear();
      _quantityController.clear();
      _quantity = 1;
      _profit = 0.0;
      _sellingPrice = 0.0;
      _costPrice = 0.0;
      _sellingPriceUsd = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 158, 158, 1),
        title: Text('BMMA Calculator'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(0, 158, 158, 1),
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
                    Positioned(
                      top: 30,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          'Sell at USD ' +
                              _sellingPriceUsd.toStringAsFixed(2) +
                              ' or ZWL ' +
                              _sellingPrice.toStringAsFixed(2) +
                              ' each',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          'Profit: $_profit%',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 10,
                      child: Text(
                        DateFormat('dd-MM-yyyy')
                            .format(DateTime.now())
                            .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 10,
                      child: Text(
                        'USD 1 = ZWL $_averageRate',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //draggable sheet
            DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 235, 248, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // margin: EdgeInsets.symmetric(horizontal: 10),

                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: DropdownButton<String>(
                                        value: currency,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 20,
                                        elevation: 16,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(0, 158, 158, 1)),
                                        underline: Container(
                                          height: 2,
                                          color: Color.fromRGBO(0, 158, 158, 1),
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            currency = newValue;
                                            _calculateSellingPrice();
                                          });
                                        },
                                        items: <String>['ZWL', 'USD']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        maxLength: 10000,
                                        controller: _costPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Buying Price',
                                          prefixText: '$currency ',
                                          labelStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1)),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        maxLength: 5,
                                        controller: _quantityController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Quantity',
                                          labelStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1)),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 158, 158, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 300,
                                  child: TextField(
                                    maxLength: 4,
                                    controller: _profitController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: '% Profit',
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 158, 158, 1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 158, 158, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 158, 158, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 80.0),
                                    child: RaisedButton(
                                      elevation: 5,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      onPressed: _calculateSellingPrice,
                                      color: Color.fromRGBO(0, 158, 158, 1),
                                      child: Text(
                                        "Calculate",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: RaisedButton(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 5,
                                          right: 5),
                                      onPressed: _clear,
                                      color: Colors.red,
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                          child: Stack(
                            children: <Widget>[
                              Card(
                                elevation: 30,
                                margin: EdgeInsets.only(left: 20, top: 20),
                                color: Colors.white,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Container(
                                    padding: EdgeInsets.all(30),
                                    child: Center(
                                      child: Text(
                                        '''I have been studying the ZWL - USD rate for you, it seems to be rising contanstly monthly at this {s}. ncrease your weekly sales or review the prices weekly.''',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(0, 158, 158, 1),
                                  radius: 35,
                                  child: Icon(
                                    Icons.info,
                                    size: 40,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
      ),
    );
  }
}
