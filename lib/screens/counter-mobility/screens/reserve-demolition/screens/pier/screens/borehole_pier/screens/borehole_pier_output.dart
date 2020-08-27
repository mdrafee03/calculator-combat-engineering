import 'package:flutter/material.dart';

import '../models/borehole_pier.dart';

class BoreholePierOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Borehole Pier Result'),
  );
  @override
  Widget build(BuildContext context) {
    final BoreholePier _borehole = ModalRoute.of(context).settings.arguments;
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
                  'SUMMARY OF PIER RESULT',
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
                      "a. No of holes require one row = ${_borehole.noOfHolesPerRow} Nos",
                    ),
                    Text(
                      "b. No of rows = ${_borehole.row} Nos",
                    ),
                    Text(
                      "c. Total no of holes = ${_borehole.totalNoOfholes} Nos",
                    ),
                    Text(
                      "d. Depth of hole = ${_borehole.depthOfHole}''",
                    ),
                    Text(
                      "e. Depth of explosive to be filled = ${_borehole.depthOfExplosiveToBeFilled}''",
                    ),
                    Text(
                      "f. Dia of borehole = ${_borehole.diaOfBorehole}''",
                    ),
                    Text(
                      "g. Charge required in one hole = ${_borehole.chargeRequiredOneHole.toStringAsFixed(2)} oz PE",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "h. Total Charge required in one pier",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                " = ${(_borehole.totalChargeRequiredOnePier * 16).toStringAsFixed(2)} oz"),
                            Text(
                                " = ${_borehole.totalChargeRequiredOnePier.toStringAsFixed(2)} lb")
                          ],
                        )
                      ],
                    ),
                    Text(
                      "i. Total amount of charge required = ${_borehole.totalAmountForAllPiers.toStringAsFixed(2)} lb",
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
