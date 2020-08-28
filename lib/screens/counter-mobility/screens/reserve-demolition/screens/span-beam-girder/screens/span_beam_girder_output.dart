import 'package:flutter/material.dart';

import '../models/span_beam_girder.dart';

class SpanBeamGirderOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Demolition of Span, Beam and Girder Result'),
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
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SUMMARY OF SPAN, BEAM AND GIRDER RESULT',
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
                      "a. Charge of each beam = ${_model.chargeOfEachBeam.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "b. Total charge for beams = ${_model.totalChargeBeams.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "c. Total charge for spans = ${_model.totalChargeSpans.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "d. Sand Bag Required for one span = ${_model.sanbagPerSpan} Nos",
                    ),
                    Text(
                      "e. Total Sand Bag Required for demolition of spans = ${_model.totalSandbagForSpan} Nos",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "f. Total required for ${_model.noOfSpans} spans ",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "= ${_model.timeRequiredPerSection} hrs for a section",
                            ),
                            Text(
                              "= ${_model.totalTimeRequired.toStringAsFixed(2)} platoon hours",
                            ),
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
