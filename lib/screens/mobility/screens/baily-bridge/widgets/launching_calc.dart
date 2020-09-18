import 'package:flutter/material.dart';

import '../models/launching_calc.dart';
import '../models/baily_bridge.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';

class LaunchingCalcBailyBridge extends StatelessWidget {
  final List<PositionRollers> positions;
  final List<LaunchingCalc> lauchings;
  final double farbank;
  final int sl;
  LaunchingCalcBailyBridge({
    @required this.sl,
    @required this.positions,
    @required this.farbank,
    @required this.lauchings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SectionSubHeading(
                "$sl .",
                "Launching Calculation",
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Table(
                            columnWidths: {
                              0: FixedColumnWidth(25),
                              1: FixedColumnWidth(150),
                              2: FixedColumnWidth(positions
                                      .contains(PositionRollers.Roller102)
                                  ? 280
                                  : positions.contains(PositionRollers.Roller77)
                                      ? 240
                                      : 200),
                            },
                            border: TableBorder(
                              top: BorderSide(width: 1),
                              verticalInside: BorderSide(width: 1),
                              left: BorderSide(width: 1),
                              right: BorderSide(width: 1),
                            ),
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Text(""),
                                ),
                                TableCell(
                                  child: Text(""),
                                ),
                                TableCell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1),
                                      ),
                                    ),
                                    child:
                                        Text("Rollers at different positions"),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          Table(
                            columnWidths: {
                              0: FixedColumnWidth(25),
                              1: FixedColumnWidth(150),
                              2: FixedColumnWidth(40),
                              3: FixedColumnWidth(40),
                              4: FixedColumnWidth(40),
                              5: FixedColumnWidth(40),
                              6: FixedColumnWidth(40),
                              7: FixedColumnWidth(40),
                              8: FixedColumnWidth(40),
                            },
                            border: TableBorder(
                              verticalInside: BorderSide(width: 1),
                              left: BorderSide(width: 1),
                              right: BorderSide(width: 1),
                            ),
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Text("Ser"),
                                ),
                                TableCell(
                                  child: Text("Consideration"),
                                ),
                                if (positions
                                    .contains(PositionRollers.Roller102))
                                  TableCell(
                                    child: Text("102'"),
                                  ),
                                if (positions
                                    .contains(PositionRollers.Roller77))
                                  TableCell(
                                    child: Text("77'"),
                                  ),
                                TableCell(
                                  child: Text("52'"),
                                ),
                                TableCell(
                                  child: Text("27'"),
                                ),
                                TableCell(
                                  child: Text("3.5'"),
                                ),
                                TableCell(
                                  child: Text("0'"),
                                ),
                                TableCell(
                                  child: Text(
                                    farbank.toString(),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          Table(
                            columnWidths: {
                              0: FixedColumnWidth(25),
                              1: FixedColumnWidth(150),
                              2: FixedColumnWidth(40),
                              3: FixedColumnWidth(40),
                              4: FixedColumnWidth(40),
                              5: FixedColumnWidth(40),
                              6: FixedColumnWidth(40),
                              7: FixedColumnWidth(40),
                              8: FixedColumnWidth(40),
                            },
                            border: TableBorder.all(),
                            children: lauchings
                                .map(
                                  (element) => TableRow(children: [
                                    TableCell(
                                      child: Text(element.sl.toString()),
                                    ),
                                    TableCell(
                                      child: Text(element.consideration),
                                    ),
                                    if (positions
                                        .contains(PositionRollers.Roller102))
                                      TableCell(
                                        child: Text(element.roller102
                                            .toStringAsFixed(2)),
                                      ),
                                    if (positions
                                        .contains(PositionRollers.Roller77))
                                      TableCell(
                                        child: Text(element.roller77
                                            .toStringAsFixed(2)),
                                      ),
                                    TableCell(
                                      child: Text(
                                          element.roller52.toStringAsFixed(2)),
                                    ),
                                    TableCell(
                                      child: Text(
                                          element.roller27.toStringAsFixed(2)),
                                    ),
                                    TableCell(
                                      child: Text(
                                          element.roller3p5.toStringAsFixed(2)),
                                    ),
                                    TableCell(
                                      child: Text(
                                          element.roller0.toStringAsFixed(2)),
                                    ),
                                    TableCell(
                                      child: Text(
                                          element.farBank.toStringAsFixed(2)),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
