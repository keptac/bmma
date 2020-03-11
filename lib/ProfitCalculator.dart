import 'package:flutter/material.dart';

class ProfitCalculator extends StatefulWidget {
  @override
  _ProfitCalculatorState createState() => _ProfitCalculatorState();
}

class _ProfitCalculatorState extends State<ProfitCalculator> {
  final _profitController = TextEditingController();
  final _costPriceController = TextEditingController();
  double _profit = 0.0;
  double _costPrice = 0.0;
  double _sellingPrice = 0.0;
  double _sellingPriceUsd = 0.0;
  double _averageRate = 1.0;

  void _calculateSellingPrice() {
    if (_costPriceController.text.isNotEmpty &&
        _profitController.text.isNotEmpty) {
      _profit = double.parse(_profitController.text);
      _costPrice = double.parse(_costPriceController.text);
      _sellingPrice = (100 + _profit) * (_costPrice / 100);
      _sellingPriceUsd = _sellingPrice / _averageRate;
    } else {}
  }

  void _clear() {
    setState(() {
      _profitController.clear();
      _costPriceController.clear();
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
          backgroundColor: Colors.blue[900],
          title: Text('BMMA Calculator'),
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
                  // color: Colors.orange,
                  //put image
                  child: Center(
                    child: Text('Determine Your Selling Price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                ),
              ),

              //draggable sheet
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
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 30, top: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Your must sell at: ',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              // fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ZWL $_sellingPrice = USD $_sellingPriceUsd',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 70,
                                        width: 230,
                                        child: TextField(
                                          maxLength: 10000,
                                          controller: _costPriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.attach_money,
                                              color: Colors.blue[900],
                                              size: 20,
                                            ),
                                            labelText: 'Cost Per Unit',
                                            prefixText: 'ZWL ',
                                            labelStyle: TextStyle(
                                                color: Colors.blue[900]),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      SizedBox(
                                        height: 70,
                                        width: 130,
                                        child: TextField(
                                          maxLength: 2,
                                          controller: _profitController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.attach_money,
                                              color: Colors.blue[900],
                                              size: 20,
                                            ),
                                            labelText: '% Profit',
                                            labelStyle: TextStyle(
                                                color: Colors.blue[900]),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(20.0),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 100.0),
                                      child: RaisedButton(
                                        elevation: 5,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
                                        onPressed: _calculateSellingPrice,
                                        color: Colors.blue[900],
                                        child: Text(
                                          "Calculate",
                                          style: TextStyle(
                                            color: Colors.white,
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
