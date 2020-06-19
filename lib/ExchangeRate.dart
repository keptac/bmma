import 'package:bmma/CurrencyConvertor.dart';
import 'package:bmma/RatesScale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

List<Rates> myModels;

class ExchangeRate extends StatefulWidget {
  @override
  _ExchangeRateState createState() => _ExchangeRateState();
}

Future<Rates> fetchRates() async {
  var rates = jsonEncode([
    {"source": "Parallel Market ", "rate": "83.5"},
    {"source": 'Interbank', "rate": "25.00"},
    {"source": 'Cash', "rate": "58.40"},
  ]);

// Should be from Server or firebase
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    myModels =
        (json.decode(rates) as List).map((i) => Rates.fromJson(i)).toList();

    return Rates.fromJson(json.decode(rates)[0]);
  } else {
    myModels =
        (json.decode(rates) as List).map((i) => Rates.fromJson(i)).toList();
    return Rates.fromJson(json.decode(rates)[0]);
    // throw Exception('Failed to load rates');
  }
}

class Rates {
  final int id;
  final String source;
  final String rate;
  final String date;

  Rates({this.id, this.source, this.rate, this.date});

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
        id: json["id"],
        source: json["source"],
        rate: json["rate"],
        date: json["date"]);
  }
}

class _ExchangeRateState extends State<ExchangeRate> {
  List<charts.Series<RatesScale, int>> _seriesLineData;

  Future<Rates> futureRates;
  @override
  void initState() {
    super.initState();
    futureRates = fetchRates();
    _seriesLineData = List<charts.Series<RatesScale, int>>();
    _generateData();
  }

  _generateData() {
    var bondRate = [
      new RatesScale(0, 24.1),
      new RatesScale(1, 28.1),
      new RatesScale(2, 36.8),
      new RatesScale(3, 51.8),
      new RatesScale(4, 58.4)
    ];

    var rbz = [
      new RatesScale(0, 17.95),
      new RatesScale(1, 25.00),
      new RatesScale(2, 25.00),
      new RatesScale(3, 25.00),
      new RatesScale(4, 25.00)
    ];

    var informalMarket = [
      new RatesScale(0, 31.00),
      new RatesScale(1, 38.50),
      new RatesScale(2, 50.50),
      new RatesScale(3, 71.00),
      new RatesScale(4, 86.40)
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)), //bank purple
        id: 'Bank Rate',
        data: rbz,
        domainFn: (RatesScale ratesScale, _) => ratesScale.dayInterval,
        measureFn: (RatesScale ratesScale, _) => ratesScale.rateVal,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(
            Color(0xff109618)), // RTGS Rate Grees
        id: 'RTGS Rate',
        data: informalMarket,
        domainFn: (RatesScale ratesScale, _) => ratesScale.dayInterval,
        measureFn: (RatesScale ratesScale, _) => ratesScale.rateVal,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)), //bondRate Orange
        id: 'Bond Rate',
        data: bondRate,
        domainFn: (RatesScale ratesScale, _) => ratesScale.dayInterval,
        measureFn: (RatesScale ratesScale, _) => ratesScale.rateVal,
      ),
    );
  }

  Widget customHeader(Widget widg, var title) {
    return Container(
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
                        '\nExchange Rates ' +
                        title,
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
          widg
        ],
      ),
    );
  }

//Get rates from API

  Widget ratesWidget() {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(243, 235, 248, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: FutureBuilder<Rates>(
                    future: futureRates,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5.0,
                              margin: EdgeInsets.only(
                                  right: 32, left: 32, bottom: 10),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                      ),
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
                                            "USD | ZWL",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey[900]),
                                          ),
                                          Text(
                                            myModels[index].source.toString(),
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
                                          "\$ " +
                                              myModels[index].rate.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.lightGreen),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: myModels.length,
                          padding: EdgeInsets.only(bottom: 30.0),
                          controller: ScrollController(keepScrollOffset: false),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "Sorry failed to load rates.\n\nReason:${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ));
                      }

                      // By default, show a loading spinner.
                      return Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 7),
                Center(
                  child: new RaisedButton(
                    color: Color.fromRGBO(0, 128, 128, 1),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyConvertor(),
                      ),
                    ),
                    child: Text(
                      'Currency Convertor',
                      style: TextStyle(color: Colors.white),
                    ),
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
    );
  }

  Widget ratesWidgetGraph() {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(243, 235, 248, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.57,
                  child: charts.LineChart(
                    _seriesLineData,
                    defaultRenderer: new charts.LineRendererConfig(
                        includeArea: true, stacked: false),
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.ChartTitle('Months (from February)',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle("Rate (per \$1)",
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Center(
                  child: new RaisedButton(
                    color: Color.fromRGBO(0, 128, 128, 1),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyConvertor(),
                      ),
                    ),
                    child: Text(
                      'Currency Convertor',
                      style: TextStyle(color: Colors.white),
                    ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 128, 128, 1),
          title: Text('BMMA Rates'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.attach_money)),
              Tab(icon: Icon(Icons.trending_up)),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(38, 81, 158, 1),
        body: TabBarView(
          children: [
            customHeader(ratesWidget(), 'List'),
            customHeader(ratesWidgetGraph(), 'Trends'),
          ],
        ),
      ),
    );
  }
}
