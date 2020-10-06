import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_sub_heading.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../../screens/wire-obstacle/models/wire_obstacle.dart';

class WireObstacleCombined extends StatelessWidget {
  final List<WireObstacle> model;
  final String sl;
  WireObstacleCombined({this.model, this.sl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('$sl. ', 'Store Calculation for Wire Obstacle'),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              for (int i = 0; i < model.length; i++)
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionSubHeading(
                        "${String.fromCharCode(97 + i)}. ",
                        "Wire Obstacle ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (model[i].task.barbedWire != null)
                              Text(
                                "(i) Barbed Wire = ${model[i].getValueByFrontage(model[i].task.barbedWire)}",
                              ),
                            if (model[i].task.barbedWireConcertina != null)
                              Text(
                                  "(ii) barbed Wire Concertina = ${model[i].getValueByFrontage(model[i].task.barbedWireConcertina)}"),
                            Text(
                              "(iii) Long Picket = ${model[i].getValueByFrontage(model[i].task.longPicket)}",
                            ),
                            if (model[i].task.shortPiquet != null)
                              Text(
                                "(iv) Short Picket = ${model[i].getValueByFrontage(model[i].task.shortPiquet)}",
                              ),
                            if (model[i].task.mauls != null)
                              Text(
                                "(v) Sledge Hammer = ${model[i].getValueBySection(model[i].task.mauls)}",
                              ),
                            if (model[i].task.tracingTapRoll != null)
                              Text(
                                "(vi) Tracing Tape Roll = ${model[i].getValueBySection(model[i].task.tracingTapRoll)}",
                              ),
                            if (model[i].task.wireCutter != null)
                              Text(
                                "(vii) Wire Cutter = ${model[i].getValueBySection(model[i].task.wireCutter)}",
                              ),
                            if (model[i].task.windlassingStick != null)
                              Text(
                                "(viii) Windlassing Sticks = ${model[i].getValueBySection(model[i].task.windlassingStick)}",
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
                      "Total Stores for all Wire Obstacle",
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
                            "(i) Barbed Wire= ${model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWire ?? 0))}",
                          ),
                          Text(
                            "(ii) Barbed Wire Concertina = ${model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWireConcertina ?? 0))}",
                          ),
                          Text(
                            "(iii) Long Picket = ${model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.longPicket ?? 0))}",
                          ),
                          Text(
                            "(iv) Short Picket = ${model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.shortPiquet ?? 0))}",
                          ),
                          Text(
                            "(v) Sledge Hammer = ${model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.mauls ?? 0))}",
                          ),
                          Text(
                            "(vi) Tracing Tape Roll = ${model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.tracingTapRoll ?? 0))}",
                          ),
                          Text(
                            "(vii) Wire Cutter = ${model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.wireCutter ?? 0))}",
                          ),
                          Text(
                            "(viii) Windlassing Sticks = ${model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.windlassingStick ?? 0))}",
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
            ],
          ),
        ),
      ],
    );
  }
}
