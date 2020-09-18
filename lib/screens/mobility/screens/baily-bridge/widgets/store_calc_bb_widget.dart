import 'package:flutter/material.dart';

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

  Text buildTextDash(int element) {
    return element != 0
        ? Text(element.toString())
        : Text("-", textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionSubHeading(
          "$sl .",
          "Store Calculation and Requirement of Vehicles",
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: SectionSubHeading(
            'a. ',
            "Store List",
          ),
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
                        TableCell(
                          child: Text("Ser"),
                        ),
                        TableCell(
                          child: Text("Name of Parts"),
                        ),
                        TableCell(
                          child: Text("Head"),
                        ),
                        TableCell(
                          child: Text("Intermediate"),
                        ),
                        TableCell(
                          child: Text("Tail"),
                        ),
                        TableCell(
                          child: Text("Nose"),
                        ),
                        TableCell(
                          child: Text("Total"),
                        ),
                        TableCell(
                          child: Text("10% extra"),
                        ),
                        TableCell(
                          child: Text(
                            "Grand Total",
                          ),
                        ),
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
                          (element) => TableRow(children: [
                            TableCell(
                              child: Text(element.sl.toString()),
                            ),
                            TableCell(
                              child: Text(element.name),
                            ),
                            TableCell(
                              child: buildTextDash(element.head),
                            ),
                            TableCell(
                                child: buildTextDash(element.intermediate)),
                            TableCell(child: buildTextDash(element.tail)),
                            TableCell(child: buildTextDash(element.nose)),
                            TableCell(
                              child: Text(element.total.toString()),
                            ),
                            TableCell(
                              child: Text(element.percentage.toString()),
                            ),
                            TableCell(
                              child: Text(element.grandTotal.toString()),
                            ),
                          ]),
                        )
                        .toList(),
                  ),
                  ReferenceText(
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
