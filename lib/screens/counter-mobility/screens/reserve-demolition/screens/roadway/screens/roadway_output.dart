import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/roadway/models/roadway.dart';
import 'package:flutter/material.dart';

class RoadwayOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Demolition of Roadway Result'),
  );
  @override
  Widget build(BuildContext context) {
    final Roadway _model = ModalRoute.of(context).settings.arguments;
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
                  'SUMMARY OF DEMOLISTION OF ROADWAY RESULT',
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
                      "a. Dia of the Road crater = 20'",
                    ),
                    Text(
                      "b. Depth of the Road crater = 7'",
                    ),
                    Text(
                      "c. Explosive required in one crater = 70 lb PE",
                    ),
                    Text(
                      "d. Individuals crater should be 80' apart",
                    ),
                    Text(
                      "e. Line of group craters should be 80' apart",
                    ),
                    Text(
                      "f. Total no of road crater along road width = ${_model.totalRoadCraterAlongRoadWidh}",
                    ),
                    Text(
                      "g. Total no of Line of group craters along road length = ${_model.totalLineOfGroupAlongRoadLength} Nos",
                    ),
                    Text(
                      "h. Total no of Road crater = ${_model.totalRoadCrater} Nos",
                    ),
                    Text(
                      "i. Amount of charge required = ${_model.totalCharge} Nos",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "j. Time required ",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "= ${_model.totalTimeRequiredPerSection} section hrs",
                            ),
                            Text(
                              "= ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                            )
                          ],
                        )
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
