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
                      "a. Method of Attack = hayrick (Shaped Charge)",
                    ),
                    Text(
                      "b. Dia of one column, d = ${_model.dia}'",
                    ),
                    Text(
                      "c. Circumference of one pier = ${_model.circumferencePerPier.toStringAsFixed(2)}''",
                    ),
                    Text(
                      "d. No of hayricks required = ${_model.noOfHyricks} Nos",
                    ),
                    Text(
                      "e. Total no of hayricks required = ${_model.totalNoOfHyrics} Nos",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "f. Time required ",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "= ${_model.totalTimeRequiredPerSection} section hours ",
                            ),
                            Text(
                              "= ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                            ),
                          ],
                        ),
                      ],
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
