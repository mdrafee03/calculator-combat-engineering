import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../../minefield-laying/models/minefield_laying.dart';

class MinefieldLayingCombined extends StatelessWidget {
  const MinefieldLayingCombined({
    Key key,
    @required List<MinefieldLaying> model,
  })  : _model = model,
        super(key: key);

  final List<MinefieldLaying> _model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('1. ', 'Store Calculation for Minefield Laying'),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              for (int i = 0; i < _model.length; i++)
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("${String.fromCharCode(97 + i)}. "),
                          Text(
                            "Minefield Laying ${i + 1}",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(i) Anti-Tank Mines = ${_model[i].antiTankMines}",
                            ),
                            Text(
                              "(ii) Anti-Personnel Mines = ${_model[i].antiPersonnelMines}",
                            ),
                            Text(
                              "(iii) Long Picket = ${_model[i].longPicket}",
                            ),
                            Text(
                              "(iv) Short Picket = ${_model[i].shortPicket}",
                            ),
                            Text(
                              "(v) Barbed Wire = ${_model[i].barbedWire}",
                            ),
                            Text(
                              "(vi) Perimeter Post = ${_model[i].perimeterSignPosting}",
                            ),
                            Text(
                              "(vii) Tracing Tape = ${_model[i].tracingTape}",
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
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Anti-Tank Mines = ${_model.fold(0, (previousValue, element) => previousValue + element.antiTankMines)}",
                          ),
                          Text(
                              "(ii) Anti-Personnel Mines = ${_model.fold(0, (previousValue, element) => previousValue + element.antiPersonnelMines)}"),
                          Text(
                              "(iii) Long Picket = ${_model.fold(0, (previousValue, element) => previousValue + element.longPicket)}"),
                          Text(
                              "(iv) Short Picket = ${_model.fold(0, (previousValue, element) => previousValue + element.shortPicket)}"),
                          Text(
                              "(v) Barbed Wire = ${_model.fold(0, (previousValue, element) => previousValue + element.barbedWire)}"),
                          Text(
                              "(vi) Perimeter Post = ${_model.fold(0, (previousValue, element) => previousValue + element.perimeterSignPosting)}"),
                          Text(
                              "(vii) Tracing Tape = ${_model.fold(0, (previousValue, element) => previousValue + element.tracingTape)}"),
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
    );
  }
}
