import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart';

import '../../../../../shared/widgets/reference_text_pw.dart';
import '../../../../../shared/widgets/section_sub_heading_pw.dart';
import '../models/store_bridge.dart';

class StoreCalcBBWidgetPw extends StatelessWidget {
  final int sl;
  final List<StoreBridge> stores;
  StoreCalcBBWidgetPw({
    @required this.sl,
    @required this.stores,
  });

  Text buildTextDash(int element) {
    return element != 0
        ? Text(element.toString())
        : Text("-", textAlign: TextAlign.center);
  }

  @override
  Widget build(Context context) {
    return Column(
      children: [
        SectionSubHeadingPw(
          "$sl .",
          "Store Calculation",
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(25),
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(120),
                      3: FixedColumnWidth(40),
                      4: FixedColumnWidth(40),
                      5: FixedColumnWidth(40),
                      6: FixedColumnWidth(40),
                    },
                    border: TableBorder(
                      top: true,
                      verticalInside: true,
                      left: true,
                      right: true,
                    ),
                    children: [
                      TableRow(children: [
                        Text(""),
                        Text(""),
                        Container(
                          decoration: BoxDecoration(
                            border: BoxBorder(
                              bottom: true,
                            ),
                          ),
                          child: Text(
                            "Main Bridge",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(""),
                        Text(""),
                        Text(""),
                        Text(""),
                      ]),
                    ],
                  ),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(25),
                      1: FixedColumnWidth(70),
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
                      TableRow(children: [
                        Text("Ser"),
                        Text("Name of Parts"),
                        Text("Head"),
                        Text("Intermediate"),
                        Text("Tail"),
                        Text("Nose"),
                        Text("Total"),
                        Text("10% extra"),
                        Text("Grand Total"),
                      ]),
                    ],
                  ),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(25),
                      1: FixedColumnWidth(70),
                      2: FixedColumnWidth(40),
                      3: FixedColumnWidth(40),
                      4: FixedColumnWidth(40),
                      5: FixedColumnWidth(40),
                      6: FixedColumnWidth(40),
                      7: FixedColumnWidth(40),
                      8: FixedColumnWidth(40),
                    },
                    border: TableBorder(),
                    children: stores
                        .map(
                          (element) => TableRow(
                            children: [
                              Text(element.sl.toString()),
                              Text(element.name),
                              buildTextDash(element.head),
                              buildTextDash(element.intermediate),
                              buildTextDash(element.tail),
                              buildTextDash(element.nose),
                              Text(element.total.toString()),
                              Text(element.percentage.toString()),
                              Text(element.grandTotal.toString()),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  ReferenceTextPw(
                      "(Auth: ME Volume III part III, Annex E) Page-140)")
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
