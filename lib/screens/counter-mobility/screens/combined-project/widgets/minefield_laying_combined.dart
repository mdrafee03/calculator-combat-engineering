import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../../minefield-laying/models/minefield_laying.dart';

class MinefieldLayingCombined extends StatelessWidget {
  final List<MinefieldLaying> model;
  final String sl;
  MinefieldLayingCombined({this.model, this.sl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('$sl. ', 'Store Calculation for Minefield Laying'),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              for (int i = 0; i < model.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionSubHeading(
                      "${String.fromCharCode(97 + i)}. ",
                      "Minefield Laying ${i + 1}",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Anti-Tank Mines = ${model[i].antiTankMines}",
                          ),
                          Text(
                            "(ii) Anti-Personnel Mines = ${model[i].antiPersonnelMines}",
                          ),
                          Text(
                            "(iii) Long Picket = ${model[i].longPicket}",
                          ),
                          Text(
                            "(iv) Short Picket = ${model[i].shortPicket}",
                          ),
                          Text(
                            "(v) Barbed Wire = ${model[i].barbedWire}",
                          ),
                          Text(
                            "(vi) Perimeter Post = ${model[i].perimeterSignPosting}",
                          ),
                          Text(
                            "(vii) Tracing Tape = ${model[i].tracingTape}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Stores for all Minefield Laying",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
                          "(i) Anti-Tank Mines = ${model.fold(0, (previousValue, element) => previousValue + element.antiTankMines)}",
                        ),
                        Text(
                            "(ii) Anti-Personnel Mines = ${model.fold(0, (previousValue, element) => previousValue + element.antiPersonnelMines)}"),
                        Text(
                            "(iii) Long Picket = ${model.fold(0, (previousValue, element) => previousValue + element.longPicket)}"),
                        Text(
                            "(iv) Short Picket = ${model.fold(0, (previousValue, element) => previousValue + element.shortPicket)}"),
                        Text(
                            "(v) Barbed Wire = ${model.fold(0, (previousValue, element) => previousValue + element.barbedWire)}"),
                        Text(
                            "(vi) Perimeter Post = ${model.fold(0, (previousValue, element) => previousValue + element.perimeterSignPosting)}"),
                        Text(
                            "(vii) Tracing Tape = ${model.fold(0, (previousValue, element) => previousValue + element.tracingTape)}"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
