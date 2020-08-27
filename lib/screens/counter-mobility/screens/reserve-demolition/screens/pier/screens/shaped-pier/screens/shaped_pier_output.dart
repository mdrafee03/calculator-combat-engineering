import 'package:flutter/material.dart';

import '../models/shaped_pier.dart';

class ShapedPierOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Shaped Charge Result'),
  );
  @override
  Widget build(BuildContext context) {
    final ShapedPier _shaped = ModalRoute.of(context).settings.arguments;
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
                      'Calculation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Dia of one column, d = ${_shaped.dia}'",
                    ),
                    Text(
                      "b. Circumference of one pier = ${_shaped.circumferencePerPier.toStringAsFixed(2)}''",
                    ),
                    Text(
                      "c. No of hayricks required = ${_shaped.noOfHyricks} Nos",
                    ),
                    Text(
                      "d. Total no of hayricks required = ${_shaped.totalNoOfHyrics} Nos",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
