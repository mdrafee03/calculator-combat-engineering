import 'package:combat_engineering/shared/widgets/heading_output.dart';
import 'package:combat_engineering/shared/widgets/placement_of_charges.dart';
import 'package:combat_engineering/shared/widgets/summary_of_calculation.dart';
import 'package:combat_engineering/shared/widgets/time_requirement.dart';
import 'package:flutter/material.dart';

import '../models/span_beam_girder.dart';

class SpanBeamGirderOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Span, Beam and Girder'),
  );
  @override
  Widget build(BuildContext context) {
    final SpanBeamGirder _model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput(
                  'Demolition of Span, Beam And Girder By Pressure Charge'),
              SummaryOfCalculation(),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Charge of each beam = ${_model.chargeOfEachBeam.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "b. Total amount of charge require for ${_model.noOfBeams} beams = ${_model.totalChargeBeams.toStringAsFixed(2)} lb PE",
                    ),
                    Text(
                      "c. Total charge require for ${_model.noOfSpans} spans = ${_model.totalChargeSpans.toStringAsFixed(2)} lb PE",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "d. Sand Bag Require for one span = ${_model.sanbagPerSpan} Nos",
                    ),
                    Text(
                      "e. Total Sand Bag Required for demolition of spans = ${_model.totalSandbagForSpan} Nos",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
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
                      "a. Total time require for demolition one ${_model.noOfSpans} Spans",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "= ${_model.timeRequiredPerSection} section hours ",
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
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/span_beam_girder1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/span_beam_girder2.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/span_beam_girder3.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
