import 'package:flutter/material.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../shared/models/utility.dart';
import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../models/minefield_breaching.dart';

class MinefieldBreachingOutput extends StatelessWidget {
  final SerialManage slForParent = SerialManage();

  @override
  Widget build(BuildContext context) {
    final MinefieldBreaching _model = ModalRoute.of(context).settings.arguments;
    _model.timeCalculation;
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
          child: Column(
            children: [
              TopHeader('Summary of Minefield Breaching'),
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
                                Utility.buildTableHeader("Ser"),
                                Utility.buildTableHeader("Party"),
                                Utility.buildTableHeader("Task"),
                                Utility.buildTableHeader("Time"),
                                Utility.buildTableHeader("From"),
                                Utility.buildTableHeader("To"),
                              ]),
                              ...breachingList.branchingLane.map((lane) {
                                return TableRow(children: [
                                  lane.startParty
                                      ? Utility.buildTableCell(
                                          lane.serial.toString(),
                                          isCenter: true,
                                        )
                                      : TableCell(
                                          child: Text(""),
                                        ),
                                  lane.startParty
                                      ? Utility.buildTableCell(lane.party)
                                      : TableCell(
                                          child: Text(""),
                                        ),
                                  Utility.buildTableCell(lane.task),
                                  Utility.buildTableCell(
                                    lane.time.toString(),
                                    isCenter: true,
                                  ),
                                  Utility.buildTableCell(
                                    _model.hourFormat(lane.from),
                                    isCenter: true,
                                  ),
                                  Utility.buildTableCell(
                                    _model.hourFormat(lane.to),
                                    isCenter: true,
                                  ),
                                ]);
                              }).toList(),
                            ],
                          ),
                          SizedBox(height: 20),
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
              Column(
                children: [
                  Image.asset(
                    'assets/images/minefield-breaching/minefield-breaching1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/minefield-breaching/minefield-breaching2.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
