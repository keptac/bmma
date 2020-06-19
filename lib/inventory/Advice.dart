import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Advice extends StatefulWidget {
  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {

  double _profit = 0.0;
  
  double _sellingPrice = 0.0;
  double _sellingPriceUsd = 0.0;
  double _averageRate = 83.5;
  String currency = 'ZWL';




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
                                        '''I have been studying the ZWL - USD rate for you, it seems to be rising constantly weekly at this {rate}. Since you horded using USD it would be advisable to sell your product in USD, if however you decide to sell in ZWL, you will have increase your weekly sales or review the prices weekly.''',
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
