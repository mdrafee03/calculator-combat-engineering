import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/abutment/models/abutment.dart';
import 'package:flutter/material.dart';

class AbutmentOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Abutment Result'),
  );
  @override
  Widget build(BuildContext context) {
    final Abutment _model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SUMMARY OF ABUTMENT RESULT',
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
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Table(
                      columnWidths: {0: FixedColumnWidth(100)},
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  'No of Charge',
                                ),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(
                                  i.toString(),
                                ),
                              ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  'Crater Dia in ft',
                                ),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(
                                    _model.craterDia(i).toStringAsFixed(2)),
                              )
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text('Each Charges in lbs'),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(_model
                                    .weightOfCharges(i)
                                    .toStringAsFixed(2)),
                              )
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text('Total Explosive in lbs'),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(_model
                                    .totalExclusive(i)
                                    .toStringAsFixed(2)),
                              )
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text('Distance from face in ft'),
                                ),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                  child: Text(
                                      "${_model.distanceFromFace(i)[0].toStringAsFixed(2)} - ${_model.distanceFromFace(i)[1].toStringAsFixed(2)}")),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text('Spacing of charges in ft'),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(_model
                                    .spacingOfCharges(i)
                                    .toStringAsFixed(2)),
                              ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text('Charges Depth in ft'),
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                  child: Text(
                                      "${_model.chargesDepth(i)[0].toStringAsFixed(2)} - ${_model.chargesDepth(i)[1].toStringAsFixed(2)}")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text('1. '),
                          Text(
                            'Summary of Calculation',
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
                          Text("a. Type of Attack = Mined Charge"),
                          Text(
                            "b. Type of target = ${typesOfTarget.firstWhere((target) => target["value"] == _model.targetFactor)['type']}",
                          ),
                          Text(
                            "c. Total Explosive Require = ${_model.totalExclusive(_model.craterNo).toStringAsFixed(2)} lbs",
                          ),
                          Text("d. Total no of craters = 5"),
                          Text(
                            "e. Crater Dia = ${_model.craterDia(_model.craterNo).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "f. Distance from face = ${_model.distanceFromFace(_model.craterNo)[0].toStringAsFixed(2)} - ${_model.distanceFromFace(_model.craterNo)[1].toStringAsFixed(2)} ft = ${((_model.distanceFromFace(_model.craterNo)[0] + _model.distanceFromFace(_model.craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "g. Spacing of Charges = ${_model.spacingOfCharges(_model.craterNo).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "h. Depth of Charges = ${_model.chargesDepth(_model.craterNo)[0].toStringAsFixed(2)} - ${_model.chargesDepth(_model.craterNo)[1].toStringAsFixed(2)} ft = ${((_model.chargesDepth(_model.craterNo)[0] + _model.chargesDepth(_model.craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                              "a. For 3 craters time Requirement 2 section hours."),
                          Text(
                            "b. For ${_model.craterNo} craters time required = ${_model.timeRequiredPerSection.toStringAsFixed(2)} section hour",
                          ),
                          Text(
                            "c. For 1 section ${_model.timeRequiredPerSection.toStringAsFixed(2)} section hour will be required",
                          ),
                          Text(
                              "d. Time Requirement by a platoon = ${_model.timeRequiredByPlatoon} Platoon hour"),
                          Text(
                            "    (Auth: ERPB 1964, Chapter IV, serial 10, page 146)",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text('3. '),
                          Text(
                            'Placement of Cahrge',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
