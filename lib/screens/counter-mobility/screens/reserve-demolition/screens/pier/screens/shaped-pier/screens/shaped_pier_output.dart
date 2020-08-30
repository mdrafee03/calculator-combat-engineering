import 'package:flutter/material.dart';

import '../models/shaped_pier.dart';

class ShapedPierOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Shaped Charge Result'),
  );
  @override
  Widget build(BuildContext context) {
    final ShapedPier _model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SUMMARY OF SHAPED CHARGE RESULT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      '1. ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Summay of Calculation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Method of Attack = Hayrick (Shaped Charge)",
                    ),
                    Text(
                      "b. Dia of one column, d = ${_model.dia} ft",
                    ),
                    Text(
                      "c. Circumference of one pier = ${_model.circumferencePerPier.toStringAsFixed(2)} ft",
                    ),
                    Text(
                      "d. Number of hayricks required = ${_model.noOfHyricks} Nos",
                    ),
                    Text(
                      "e. Total no of hayricks required for ${_model.noOfPier} piers = ${_model.totalNoOfHyrics} Nos",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      '2. ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Time Requirement',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "a. Time require for demolition of ${_model.noOfPier} piers",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "= ${_model.totalTimeRequiredPerSection} section hours ",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "= ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text("   (Auth : FEMW pamph-3 sec 21 Para -7")
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      '3. ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Placement of Charges',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
