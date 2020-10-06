import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart';

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
          border: TableBorder(
            top: true,
            verticalInside: true,
            left: true,
            right: true,
          ),
          children: [
            TableRow(
              children: [
                Text(""),
                Text(""),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(
                      bottom: true,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text("Rollers at different positions"),
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
            verticalInside: true,
            left: true,
            right: true,
          ),
          children: [
            TableRow(
              children: [
                Text("Ser"),
                Text("Consideration"),
                if (positions.contains(PositionRollers.Roller102)) Text("102'"),
                if (positions.contains(PositionRollers.Roller77)) Text("77'"),
                Text("52'"),
                Text("27'"),
                Text("3.5'"),
                Text("0'"),
                Text(farbank.toString()),
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
                    Text(element.sl.toString()),
                    Text(element.consideration),
                    if (positions.contains(PositionRollers.Roller102))
                      Text(element.roller102.toStringAsFixed(2)),
                    if (positions.contains(PositionRollers.Roller77))
                      Text(element.roller77.toStringAsFixed(2)),
                    Text(element.roller52.toStringAsFixed(2)),
                    Text(element.roller27.toStringAsFixed(2)),
                    Text(element.roller3p5.toStringAsFixed(2)),
                    Text(element.roller0.toStringAsFixed(2)),
                    Text(element.farBank.toStringAsFixed(2)),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
