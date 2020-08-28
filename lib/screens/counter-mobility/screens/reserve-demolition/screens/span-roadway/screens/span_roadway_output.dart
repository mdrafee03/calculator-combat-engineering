import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/span-roadway/models/span_roadway.dart';
import 'package:flutter/material.dart';

class SpanRoadwayOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Demolition of Span or Roadway Result'),
  );
  @override
  Widget build(BuildContext context) {
    final SpanRoadway _model = ModalRoute.of(context).settings.arguments;
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
                  'SUMMARY OF SPAN OR ROADWAY RESULT',
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
                    // Text(
                    //   "b. No of charge = ${_model.totalNoOfCharge} Nos",
                    // ),
                    // Text(
                    //   "c. Total amount of charge required = ${_model.totalAmountCharge.toStringAsFixed(2)} lb CE TNT",
                    // ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text("d. Spacing of charge",
                    //         style: TextStyle(fontWeight: FontWeight.bold)),
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "(i) Dist of outer charges from edges of pier = ${_model.outerCharges.toStringAsFixed(2)}''",
                    //           ),
                    //           Text(
                    //             "(ii) Inner charges, charge to charge distance = ${_model.innerCharges.toStringAsFixed(2)}''",
                    //           ),
                    //           Text('(iii) Charges should be well temped.')
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Text("e.")
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
