import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/abutment/models/abutment.dart';
import 'package:flutter/material.dart';

class AbutmentOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Abutment Result'),
  );
  @override
  Widget build(BuildContext context) {
    final Abutment _abutment = ModalRoute.of(context).settings.arguments;
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
                              child: Text(
                                'No of Charge',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            for (int i = 1; i < 6; i++)
                              TableCell(
                                child: Text(
                                  i.toString(),
                                  textAlign: TextAlign.center,
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
                                    _abutment.craterDia(i).toStringAsFixed(2)),
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
                                child: Text(_abutment
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
                                child: Text(_abutment
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
                                      "${_abutment.distanceFromFace(i)[0].toStringAsFixed(2)} - ${_abutment.distanceFromFace(i)[1].toStringAsFixed(2)}")),
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
                                child: Text(_abutment
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
                                      "${_abutment.chargesDepth(i)[0].toStringAsFixed(2)} - ${_abutment.chargesDepth(i)[1].toStringAsFixed(2)}")),
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
                          Text(
                            'Result',
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
                            "a. Type of target = ${typesOfTarget.firstWhere((target) => target["value"] == _abutment.targetFactor)['type']}",
                          ),
                          Text(
                            "b. Total Explosive Require = ${_abutment.totalExclusive(_abutment.craterNo).toStringAsFixed(2)} lbs",
                          ),
                          Text("c. Total no of craters = 5"),
                          Text(
                            "d. Crater Dia = ${_abutment.craterDia(_abutment.craterNo).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "e. Distance from face = ${_abutment.distanceFromFace(_abutment.craterNo)[0].toStringAsFixed(2)} - ${_abutment.distanceFromFace(_abutment.craterNo)[1].toStringAsFixed(2)} ft = ${((_abutment.distanceFromFace(_abutment.craterNo)[0] + _abutment.distanceFromFace(_abutment.craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "e. Spacing of Charges = ${_abutment.spacingOfCharges(_abutment.craterNo).toStringAsFixed(2)} ft",
                          ),
                          Text(
                            "e. Depth of Charges = ${_abutment.chargesDepth(_abutment.craterNo)[0].toStringAsFixed(2)} - ${_abutment.chargesDepth(_abutment.craterNo)[1].toStringAsFixed(2)} ft = ${((_abutment.chargesDepth(_abutment.craterNo)[0] + _abutment.chargesDepth(_abutment.craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
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
