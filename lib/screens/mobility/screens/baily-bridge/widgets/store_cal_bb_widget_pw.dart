import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart';

import '../../../../../shared/models/utility_pw.dart';
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

  Container buildTextDash(int element) {
    return element != 0
        ? UtilityPw.buildTableCell(element.toString(), isCenter: true)
        : UtilityPw.buildTableCell("-", isCenter: true);
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
                      horizontalInside: false,
                      bottom: false,
                    ),
                    children: [
                      TableRow(children: [
                        Text(""),
                        Text(""),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: BoxBorder(
                              bottom: true,
                            ),
                          ),
                          child: Text(
                            "Main Bridge",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      top: false,
                      bottom: false,
                      horizontalInside: false,
                    ),
                    children: [
                      TableRow(children: [
                        UtilityPw.buildTableHeader("Ser"),
                        UtilityPw.buildTableHeader("Name of Parts"),
                        UtilityPw.buildTableHeader("Head"),
                        UtilityPw.buildTableHeader("Intermediate"),
                        UtilityPw.buildTableHeader("Tail"),
                        UtilityPw.buildTableHeader("Nose"),
                        UtilityPw.buildTableHeader("Total"),
                        UtilityPw.buildTableHeader("10% extra"),
                        UtilityPw.buildTableHeader("Grand Total"),
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
                              UtilityPw.buildTableCell(
                                element.sl.toString(),
                                isCenter: true,
                              ),
                              UtilityPw.buildTableCell(element.name),
                              buildTextDash(element.head),
                              buildTextDash(element.intermediate),
                              buildTextDash(element.tail),
                              buildTextDash(element.nose),
                              UtilityPw.buildTableCell(
                                element.total.toString(),
                                isCenter: true,
                              ),
                              UtilityPw.buildTableCell(
                                element.percentage.toString(),
                                isCenter: true,
                              ),
                              UtilityPw.buildTableCell(
                                element.grandTotal.toString(),
                                isCenter: true,
                              ),
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
