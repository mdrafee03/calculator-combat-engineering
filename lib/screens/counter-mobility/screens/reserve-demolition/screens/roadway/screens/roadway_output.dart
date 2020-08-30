import 'package:flutter/material.dart';

import '../models/roadway.dart';
import '../../../../../../../shared/widgets/summary_of_calculation.dart';
import '../../../../../../../shared/widgets/heading_output.dart';
import '../../../../../../../shared/widgets/time_requirement.dart';
import '../../../../../../../shared/widgets/placement_of_charges.dart';

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
              HeadingOutput("Demolition of Roadway"),
              SummaryOfCalculation(),
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
                      "e. Line of group craters should be 10' apart",
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
                      "j. Amount of charge required = ${_model.totalCharge.toStringAsFixed(2)} lb PE",
                    ),
                  ],
                ),
              ),
              TimeRequirement(),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "a. Time require for road crater",
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
                  ],
                ),
              ),
              PlacementOfCharges(),
            ],
          ),
        ),
      ),
    );
  }
}
