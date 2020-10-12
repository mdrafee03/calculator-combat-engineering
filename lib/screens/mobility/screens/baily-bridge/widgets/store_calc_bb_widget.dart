import 'package:flutter/material.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/reference_text.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../models/store_bridge.dart';

class StoreCalcBBWidget extends StatelessWidget {
  final int sl;
  final List<StoreBridge> stores;
  StoreCalcBBWidget({
    @required this.sl,
    @required this.stores,
  });

  Container buildTextDash(int element) {
    return element != 0
        ? Utility.buildTableCell(element.toString(), isCenter: true)
        : Utility.buildTableCell("-", isCenter: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionSubHeading(
          "$sl .",
          "Store Calculation",
        ),
        Container(
          alignment: Alignment.topLeft,
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
                        1: FixedColumnWidth(70),
                        2: FixedColumnWidth(120),
                        3: FixedColumnWidth(40),
                        4: FixedColumnWidth(40),
                        5: FixedColumnWidth(40),
                        6: FixedColumnWidth(40),
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
                              child: Text(
                                "Main Bridge",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                        verticalInside: BorderSide(width: 1),
                        left: BorderSide(width: 1),
                        right: BorderSide(width: 1),
                      ),
                      children: [
                        TableRow(children: [
                          Utility.buildTableHeader("Ser"),
                          Utility.buildTableHeader("Name of Parts"),
                          Utility.buildTableHeader("Head"),
                          Utility.buildTableHeader("Intermediate"),
                          Utility.buildTableHeader("Tail"),
                          Utility.buildTableHeader("Nose"),
                          Utility.buildTableHeader("Total"),
                          Utility.buildTableHeader("10% extra"),
                          Utility.buildTableHeader("Grand Total"),
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
                      border: TableBorder.all(),
                      children: stores
                          .map(
                            (element) => TableRow(
                              children: [
                                Utility.buildTableCell(
                                  element.sl.toString(),
                                  isCenter: true,
                                ),
                                Utility.buildTableCell(element.name),
                                buildTextDash(element.head),
                                buildTextDash(element.intermediate),
                                buildTextDash(element.tail),
                                buildTextDash(element.nose),
                                Utility.buildTableCell(
                                  element.total.toString(),
                                  isCenter: true,
                                ),
                                Utility.buildTableCell(
                                  element.percentage.toString(),
                                  isCenter: true,
                                ),
                                Utility.buildTableCell(
                                  element.grandTotal.toString(),
                                  isCenter: true,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    ReferenceText(
                        "(Auth: ME Volume III part III, Annex E) Page-140)")
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
