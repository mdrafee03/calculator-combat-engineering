import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/top_header.dart';
import '../../../../../widgets/placement_of_charges.dart';
import '../../../../../widgets/summary_of_calculation.dart';
import '../../../../../widgets/time_requirement.dart';
import '../models/abutment.dart';

class AbutmentOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Abutment _model = ModalRoute.of(context).settings.arguments;
    final AppBar appbar = AppBar(
      title: Text("Abutment"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              abutmentList,
              ModalRoute.withName(reserveDemolitionChildren),
            );
          },
        ),
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
          child: Column(children: [
            TopHeader('Summary of abutment demolition'),
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
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                              child:
                                  Text(_model.craterDia(i).toStringAsFixed(2)),
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
                              child: Text(
                                  _model.weightOfCharges(i).toStringAsFixed(2)),
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
                                  .totalChargeRequired(i)
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
                  SummaryOfCalculation(),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("a. Method of Attack = Mined Charge"),
                        Text(
                          "b. Type of target = ${Abutment.typesOfTarget.firstWhere((target) => target["value"] == _model.targetFactor)['type']}",
                        ),
                        Text(
                          "c. Total Explosive Require = ${_model.totalChargeRequired(_model.craterNo).toStringAsFixed(2)} lbs",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("d. Total no of craters = ${_model.craterNo}"),
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
                  TimeRequirement(),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. For 3 craters time Requirement 2 section hours.",
                        ),
                        Text(
                          "(Auth: ERPB 1964, Chapter IV, serial 10, page 146)",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "b. Total Time Require for ${_model.craterNo} craters ",
                              style: TextStyle(
                                color: Color(0xFF00008B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "= ${_model.timeRequiredPerSection.toStringAsFixed(2)} section hours",
                                  style: TextStyle(
                                    color: Color(0xFF00008B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "= ${_model.totalTimeRequired} Platoon hours",
                                  style: TextStyle(
                                    color: Color(0xFF00008B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PlacementOfCharges(),
                  Container(
                    child: Image.asset(
                      'assets/images/reserve-demolition/abutment.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
