import 'package:flutter/material.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../models/minefield_breaching.dart';

class MinefieldBreachingOutput extends StatelessWidget {
  final SerialManage slForBankPart = SerialManage();
  final SerialManage slForParent = SerialManage();
  Container buildTableCell(String cell) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
        ),
      ),
      child: Text(cell),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MinefieldBreaching _model = ModalRoute.of(context).settings.arguments;
    _model.timeCalculation;
    slForBankPart.reset();
    slForParent.reset();
    final AppBar appbar = new AppBar(
      title: Text('Minefield Breaching'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              minefieldBreachingList,
              ModalRoute.withName(mobilityScreen),
            );
          },
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput('Summary of Minefield Breaching'),
              SectionHeading(
                "${slForParent.serialNum} .",
                "Time Calculation",
              ),
              ..._model.timeCalculation
                  .asMap()
                  .map(
                    (i, breachingList) => MapEntry(
                      i,
                      Column(
                        children: [
                          SectionSubHeading("${String.fromCharCode(i + 97)}. ",
                              "For${i != 0 ? " Next" : ""} ${breachingList.type} yards (Depth ${breachingList.depth} yards)"),
                          Table(
                            border: TableBorder(
                              verticalInside: BorderSide(width: 1),
                              top: BorderSide(width: 1),
                              left: BorderSide(width: 1),
                              right: BorderSide(width: 1),
                              bottom: BorderSide(width: 1),
                            ),
                            columnWidths: {
                              0: FixedColumnWidth(25),
                              3: FixedColumnWidth(40),
                              4: FixedColumnWidth(50),
                              5: FixedColumnWidth(50),
                            },
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Text(
                                    "Ser",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "party",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "task",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "time",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "from",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    "to",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                              ...breachingList.branchingLane.map((lane) {
                                return TableRow(children: [
                                  lane.startParty
                                      ? buildTableCell(lane.serial.toString())
                                      : TableCell(
                                          child: Text(""),
                                        ),
                                  lane.startParty
                                      ? buildTableCell(lane.party)
                                      : TableCell(
                                          child: Text(""),
                                        ),
                                  buildTableCell(lane.task),
                                  buildTableCell(lane.time.toString()),
                                  buildTableCell(_model.hourFormat(lane.from)),
                                  buildTableCell(_model.hourFormat(lane.to)),
                                ]);
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
              SectionHeading(
                "${slForParent.serialNum} .",
                "Store Calculation",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Prismatic Compass = 03 Nos",
                    ),
                    Text(
                      "b. Short Prodder = 30 Nos",
                    ),
                    Text(
                      "c. Trip Wine Feeler = 30 Nos",
                    ),
                    Text(
                      "d. Wire Cutters = 150 Nos",
                    ),
                    Text(
                      "e. Eye Protector = One Per man",
                    ),
                    Text(
                      "f. Reel of Fish line = 30 Nos",
                    ),
                    Text(
                      "g. Store for lane marking",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Long Picket = ${_model.longPicket} Nos",
                          ),
                          Text(
                            "(2) Barbed Wire Coil = ${_model.barbedWire} Nos",
                          ),
                          Text(
                            "(3) Safe Lane Marker = ${_model.safeLaneMarker} Nos",
                          ),
                          Text(
                            "(4) Green Light = Yellow light = ${_model.greenYellowLight} Nos",
                          ),
                          Text(
                            "(5) Cncertina Coil = 4 Coils",
                          ),
                          Text(
                            "(6) Tape = ${_model.tape} Nos",
                          ),
                          Text(
                            "(7) Minefield Marker = ${_model.minefieldMarker} Nos",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SectionHeading(
                "${slForParent.serialNum} .",
                "Summary of Calculation",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(1) Start Time = ${_model.hourFormat(_model.startTime)} hours D Day",
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "(2) Completion Time = ${_model.hourFormat(_model.completionTime)} hours D",
                          ),
                          if (_model.completionDay != 0)
                            TextSpan(
                              text: "+${_model.completionDay}",
                            ),
                          TextSpan(
                            text: " Day",
                          ),
                        ],
                      ),
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
