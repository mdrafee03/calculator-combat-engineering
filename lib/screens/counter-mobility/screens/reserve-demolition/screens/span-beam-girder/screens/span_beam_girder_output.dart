import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/top_header.dart';
import '../../../../../widgets/placement_of_charges.dart';
import '../../../../../widgets/summary_of_calculation.dart';
import '../../../../../widgets/time_requirement.dart';
import '../models/span_beam_girder.dart';

class SpanBeamGirderOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SpanBeamGirder _model = ModalRoute.of(context).settings.arguments;
    final AppBar appbar = AppBar(
      title: Text("Span, Beam and Girder"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(reserveDemolitionChildren),
            );
          },
        ),
        if (Platform.isAndroid)
          Builder(builder: (BuildContext ctx) {
            return IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () => _model.savePDF(ctx),
            );
          }),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _model.sharePDF(),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TopHeader(
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
                      "c. Total charge require for ${_model.noOfSpans} spans = ${_model.totalChargeRequired.toStringAsFixed(2)} lb PE",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "d. Sand Bag Require for one span = ${_model.sanbagPerSpan} Nos",
                    ),
                    Text(
                      "e. Total Sand Bag Required for demolition of spans = ${_model.totalSandbagRequired} Nos",
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
