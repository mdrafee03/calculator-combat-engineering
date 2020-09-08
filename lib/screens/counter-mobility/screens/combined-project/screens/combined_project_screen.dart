import 'package:flutter/material.dart';

import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../models/combined_project.dart';

class CombinedProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CombinedProject _model = CombinedProject();
    final AppBar appbar = new AppBar(
      title: Text('Combined Project'),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput("Combined Project"),
              SectionHeading('1. ', 'Store Calculation for Minefield Laying'),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    for (int i = 0; i < _model.minefields.length; i++)
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${String.fromCharCode(97 + i)}. Minefield Laying ${i + 1}",
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "(i) Anti-Tank Mines = ${_model.minefields[i].antiTankMines}",
                                  ),
                                  Text(
                                    "(ii) Anti-Personnel Mines = ${_model.minefields[i].antiPersonnelMines}",
                                  ),
                                  Text(
                                    "(iii) Long Picket = ${_model.minefields[i].longPicket}",
                                  ),
                                  Text(
                                    "(iv) Short Picket = ${_model.minefields[i].shortPicket}",
                                  ),
                                  Text(
                                    "(v) Barbed Wire = ${_model.minefields[i].barbedWire}",
                                  ),
                                  Text(
                                    "(vi) Perimeter Post = ${_model.minefields[i].perimeterSignPosting}",
                                  ),
                                  Text(
                                    "(vii) Tracing Tape = ${_model.minefields[i].tracingTape}",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Stores for all Minefield Laying",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "(i) Anti-Tank Mines = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.antiTankMines)}",
                                ),
                                Text(
                                    "(ii) Anti-Personnel Mines = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.antiPersonnelMines)}"),
                                Text(
                                    "(iii) Long Picket = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.longPicket)}"),
                                Text(
                                    "(iv) Short Picket = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.shortPicket)}"),
                                Text(
                                    "(v) Barbed Wire = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.barbedWire)}"),
                                Text(
                                    "(vi) Perimeter Post = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.perimeterSignPosting)}"),
                                Text(
                                    "(vii) Tracing Tape = ${_model.minefields.fold(0, (previousValue, element) => previousValue + element.tracingTape)}"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
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
