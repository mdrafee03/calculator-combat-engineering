import 'package:flutter/material.dart';

import '../models/borehole_pier.dart';

class BoreholePierOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Borehole Pier Result'),
  );
  @override
  Widget build(BuildContext context) {
    final BoreholePier _model = ModalRoute.of(context).settings.arguments;
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
                    Text('1. '),
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
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. No of holes require one row = ${_model.noOfHolesPerRow} Nos",
                    ),
                    Text(
                      "b. No of rows = ${_model.row} Nos",
                    ),
                    Text(
                      "c. Total no of holes = ${_model.totalNoOfholes} Nos",
                    ),
                    Text(
                      "d. Depth of hole = ${_model.depthOfHole}''",
                    ),
                    Text(
                      "e. Distance Between Rows = ${_model.depthOfHole}''",
                    ),
                    Text(
                      "f. Depth of explosive to be filled = ${_model.depthOfExplosiveToBeFilled}''",
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
                                      _model
                                          .chargeRequiredOneHole["dias"].length;
                                  i++)
                                Text(
                                    "${String.fromCharCode(97 + i)}. ${_model.chargeRequiredOneHole["dias"][i]["dia"]}'' dia borehole to be made for ${_model.chargeRequiredOneHole["dias"][i]["depth"]}'' depth of hole")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "h. Charge required in one hole = ${_model.chargeRequiredOneHole["charge"].toStringAsFixed(2)} oz PE",
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
                                " = ${(_model.totalChargeRequiredOnePier * 16).toStringAsFixed(2)} oz"),
                            Text(
                                " = ${_model.totalChargeRequiredOnePier.toStringAsFixed(2)} lb")
                          ],
                        )
                      ],
                    ),
                    Text(
                      "j. Total amount of charge required = ${_model.totalAmountForAllPiers.toStringAsFixed(2)} lb",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text('2. '),
                    Text(
                      'Time Requirement',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. No of holes require one row = ${_model.noOfHolesPerRow} Nos",
                    ),
                    Text(
                      "b. No of rows = ${_model.row} Nos",
                    ),
                    Text(
                      "c. Total no of holes = ${_model.totalNoOfholes} Nos",
                    ),
                    Text(
                      "d. Depth of hole = ${_model.depthOfHole}''",
                    ),
                    Text(
                      "e. Distance Between Rows = ${_model.depthOfHole}''",
                    ),
                    Text(
                      "f. Depth of explosive to be filled = ${_model.depthOfExplosiveToBeFilled}''",
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
                                      _model
                                          .chargeRequiredOneHole["dias"].length;
                                  i++)
                                Text(
                                    "${String.fromCharCode(97 + i)}. ${_model.chargeRequiredOneHole["dias"][i]["dia"]}'' dia borehole to be made for ${_model.chargeRequiredOneHole["dias"][i]["depth"]}'' depth of hole")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "h. Total time required = ${_model.chargeRequiredOneHole["time"]} min",
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
                                " = ${(_model.totalChargeRequiredOnePier * 16).toStringAsFixed(2)} oz"),
                            Text(
                                " = ${_model.totalChargeRequiredOnePier.toStringAsFixed(2)} lb")
                          ],
                        )
                      ],
                    ),
                    Text(
                      "j. Total amount of charge required = ${_model.totalAmountForAllPiers.toStringAsFixed(2)} lb",
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
