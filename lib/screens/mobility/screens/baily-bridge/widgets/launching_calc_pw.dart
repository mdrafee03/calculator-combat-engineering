import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart';

import '../../../../../shared/models/utility_pw.dart';
import '../../../../../shared/widgets/section_sub_heading_pw.dart';
import '../models/launching_calc.dart';
import '../models/baily_bridge.dart';

class LaunchingCalcBailyBridgePw extends StatelessWidget {
  final List<PositionRollers> positions;
  final List<LaunchingCalc> lauchings;
  final double farbank;
  final int sl;
  LaunchingCalcBailyBridgePw({
    @required this.sl,
    @required this.positions,
    @required this.farbank,
    @required this.lauchings,
  });

  @override
  Widget build(Context context) {
    return Column(
      children: [
        SectionSubHeadingPw(
          "$sl .",
          "Launching Calculation",
        ),
        Table(
          columnWidths: {
            0: FixedColumnWidth(25),
            1: FixedColumnWidth(150),
            2: FixedColumnWidth(positions.contains(PositionRollers.Roller102)
                ? 280
                : positions.contains(PositionRollers.Roller77) ? 240 : 200),
          },
          border: TableBorder(horizontalInside: false, bottom: false),
          children: [
            TableRow(
              children: [
                Text(""),
                Text(""),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(bottom: true),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Rollers at different positions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
          border: TableBorder(
            top: false,
            bottom: false,
            horizontalInside: false,
          ),
          children: [
            TableRow(
              children: [
                UtilityPw.buildTableHeader("Ser"),
                UtilityPw.buildTableHeader("Consideration"),
                if (positions.contains(PositionRollers.Roller102))
                  UtilityPw.buildTableHeader("102'"),
                if (positions.contains(PositionRollers.Roller77))
                  UtilityPw.buildTableHeader("77'"),
                UtilityPw.buildTableHeader("52'"),
                UtilityPw.buildTableHeader("27'"),
                UtilityPw.buildTableHeader("3.5'"),
                UtilityPw.buildTableHeader("0'"),
                UtilityPw.buildTableHeader("${farbank.ceil()}'"),
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
          border: TableBorder(),
          children: lauchings
              .map(
                (element) => TableRow(
                  children: [
                    UtilityPw.buildTableCell(element.sl.toString(),
                        isCenter: true),
                    UtilityPw.buildTableCell(element.consideration),
                    if (positions.contains(PositionRollers.Roller102))
                      UtilityPw.buildTableCell(
                        element.roller102.toStringAsFixed(2),
                        isCenter: true,
                      ),
                    if (positions.contains(PositionRollers.Roller77))
                      UtilityPw.buildTableCell(
                        element.roller77.toStringAsFixed(2),
                        isCenter: true,
                      ),
                    UtilityPw.buildTableCell(
                      element.roller52.toStringAsFixed(2),
                      isCenter: true,
                    ),
                    UtilityPw.buildTableCell(
                      element.roller27.toStringAsFixed(2),
                      isCenter: true,
                    ),
                    UtilityPw.buildTableCell(
                      element.roller3p5.toStringAsFixed(2),
                      isCenter: true,
                    ),
                    UtilityPw.buildTableCell(
                      element.roller0.toStringAsFixed(2),
                      isCenter: true,
                    ),
                    UtilityPw.buildTableCell(
                      element.farBank.toStringAsFixed(2),
                      isCenter: true,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
