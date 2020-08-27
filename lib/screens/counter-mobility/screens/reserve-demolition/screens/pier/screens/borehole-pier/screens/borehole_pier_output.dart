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
                      "e. Distance Between Rows = ${_borehole.depthOfHole}''",
                    ),
                    Text(
                      "f. Depth of explosive to be filled = ${_borehole.depthOfExplosiveToBeFilled}''",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "g. Dia of borehole",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <
                                      _borehole
                                          .chargeRequiredOneHole["dias"].length;
                                  i++)
                                Text(
                                    "${String.fromCharCode(97 + i)}. ${_borehole.chargeRequiredOneHole["dias"][i]["dia"]}'' dia borehole to be made for ${_borehole.chargeRequiredOneHole["dias"][i]["depth"]}'' depth of hole")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "h. Charge required in one hole = ${_borehole.chargeRequiredOneHole["charge"].toStringAsFixed(2)} oz PE",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "i. Total Charge required in one pier",
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
                      "j. Total amount of charge required = ${_borehole.totalAmountForAllPiers.toStringAsFixed(2)} lb",
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
