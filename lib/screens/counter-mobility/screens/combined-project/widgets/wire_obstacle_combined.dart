import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../../../screens/wire-obstacle/models/wire_obstacle.dart';

class WireObstacleCombined extends StatelessWidget {
  const WireObstacleCombined({
    Key key,
    @required List<WireObstacle> model,
  })  : _model = model,
        super(key: key);

  final List<WireObstacle> _model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('3. ', 'Store Calculation for Wire Obstacle'),
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
                            "Wire Obstacle ${i + 1}",
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
                            if (_model[i].task.barbedWire != null)
                              Text(
                                "(i) Barbed Wire = ${_model[i].getValueByFrontage(_model[i].task.barbedWire)}",
                              ),
                            if (_model[i].task.barbedWireConcertina != null)
                              Text(
                                  "(ii) barbed Wire Concertina = ${_model[i].getValueByFrontage(_model[i].task.barbedWireConcertina)}"),
                            Text(
                              "(iii) Long Picket = ${_model[i].getValueByFrontage(_model[i].task.longPicket)}",
                            ),
                            if (_model[i].task.shortPiquet != null)
                              Text(
                                "(iv) Short Picket = ${_model[i].getValueByFrontage(_model[i].task.shortPiquet)}",
                              ),
                            if (_model[i].task.mauls != null)
                              Text(
                                "(v) Sledge Hammer = ${_model[i].getValueBySection(_model[i].task.mauls)}",
                              ),
                            if (_model[i].task.tracingTapRoll != null)
                              Text(
                                "(vi) Tracing Tape Roll = ${_model[i].getValueBySection(_model[i].task.tracingTapRoll)}",
                              ),
                            if (_model[i].task.wireCutter != null)
                              Text(
                                "(vii) Wire Cutter = ${_model[i].getValueBySection(_model[i].task.wireCutter)}",
                              ),
                            if (_model[i].task.windlassingStick != null)
                              Text(
                                "(viii) Windlassing Sticks = ${_model[i].getValueBySection(_model[i].task.windlassingStick)}",
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
                            "(i) Barbed Wire= ${_model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWire ?? 0))}",
                          ),
                          Text(
                            "(ii) Barbed Wire Concertina = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWireConcertina ?? 0))}",
                          ),
                          Text(
                            "(iii) Long Picket = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.longPicket ?? 0))}",
                          ),
                          Text(
                            "(iv) Short Picket = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.shortPiquet ?? 0))}",
                          ),
                          Text(
                            "(v) Sledge Hammer = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.mauls ?? 0))}",
                          ),
                          Text(
                            "(vi) Tracing Tape Roll = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.tracingTapRoll ?? 0))}",
                          ),
                          Text(
                            "(vii) Wire Cutter = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.wireCutter ?? 0))}",
                          ),
                          Text(
                            "(viii) Windlassing Sticks = ${_model.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.windlassingStick ?? 0))}",
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
