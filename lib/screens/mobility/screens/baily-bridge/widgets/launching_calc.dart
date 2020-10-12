import 'package:flutter/material.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../models/baily_bridge.dart';
import '../models/launching_calc.dart';

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
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Rollers at different positions",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                              TableRow(
                                children: [
                                  Utility.buildTableHeader("Ser"),
                                  Utility.buildTableHeader("Consideration"),
                                  if (positions
                                      .contains(PositionRollers.Roller102))
                                    Utility.buildTableHeader("102'"),
                                  if (positions
                                      .contains(PositionRollers.Roller77))
                                    Utility.buildTableHeader("77'"),
                                  Utility.buildTableHeader("52'"),
                                  Utility.buildTableHeader("27'"),
                                  Utility.buildTableHeader("3.5'"),
                                  Utility.buildTableHeader("0'"),
                                  Utility.buildTableHeader("$farbank'"),
                                ],
                              ),
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
                                  (element) => TableRow(
                                    children: [
                                      Utility.buildTableCell(
                                          element.sl.toString(),
                                          isCenter: true),
                                      Utility.buildTableCell(
                                          element.consideration),
                                      if (positions
                                          .contains(PositionRollers.Roller102))
                                        Utility.buildTableCell(
                                          element.roller102.toStringAsFixed(2),
                                          isCenter: true,
                                        ),
                                      if (positions
                                          .contains(PositionRollers.Roller77))
                                        Utility.buildTableCell(
                                          element.roller77.toStringAsFixed(2),
                                          isCenter: true,
                                        ),
                                      Utility.buildTableCell(
                                        element.roller52.toStringAsFixed(2),
                                        isCenter: true,
                                      ),
                                      Utility.buildTableCell(
                                        element.roller27.toStringAsFixed(2),
                                        isCenter: true,
                                      ),
                                      Utility.buildTableCell(
                                        element.roller3p5.toStringAsFixed(2),
                                        isCenter: true,
                                      ),
                                      Utility.buildTableCell(
                                        element.roller0.toStringAsFixed(2),
                                        isCenter: true,
                                      ),
                                      Utility.buildTableCell(
                                        element.farBank.toStringAsFixed(2),
                                        isCenter: true,
                                      ),
                                    ],
                                  ),
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
