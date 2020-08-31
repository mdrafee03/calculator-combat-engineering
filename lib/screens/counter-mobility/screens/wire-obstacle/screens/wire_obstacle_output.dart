import 'package:flutter/material.dart';

import '../models/wire_obstacle.dart';
import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';

class WireObstacleOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Wire Obstacle'),
  );
  @override
  Widget build(BuildContext context) {
    final WireObstacle _model = ModalRoute.of(context).settings.arguments;
    _model.sl = 0;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput('Summary of Wire Obstacle'),
              SectionHeading('1. ', "Store Calculation"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ([1].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Barbed wire = ${_model.getValueByFrontage(_model.task.barbedWire)} Nos",
                      ),
                    if ([2, 3, 4].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Barbed wire concertina = ${_model.getValueByFrontage(_model.task.barbedWireConcertina)} Nos",
                      ),
                    if ([5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Concertina Coil = ${_model.getValueByFrontage(_model.task.concertinaCoil)} Nos",
                      ),
                    if ([2, 3, 4, 5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Bared wire Coil = ${_model.getValueByFrontage(_model.task.baredWireCoil)} Nos",
                      ),
                    if ([1, 2, 3, 4].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Long Piquet = ${_model.getValueByFrontage(_model.task.longPiquet)} Nos",
                      ),
                    if ([5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Long Picket (6') = ${_model.getValueByFrontage(_model.task.longPicket)} Nos",
                      ),
                    if ([1, 4].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Short Picket = ${_model.getValueByFrontage(_model.task.shortPiquet)} Nos",
                      ),
                    if ([1, 3, 4].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Maul/Sledgehammer = ${_model.getValueBySection(_model.task.mauls)} Nos",
                      ),
                    if ([5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Tracing tape Roll = ${_model.getValueByFrontage(_model.task.tracingTapRoll)} Nos",
                      ),
                    if ([1, 3, 4, 5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Wire Cutter = ${_model.getValueBySection(_model.task.wireCutter)} Nos",
                      ),
                    if ([1, 3, 4, 5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Windlassing Sticks = ${_model.getValueBySection(_model.task.windlassingStick)} Nos",
                      ),
                  ],
                ),
              ),
              SectionHeading('2. ', "Time Calculation"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Time require in ${_model.time == PartsOfDay.Day ? "Day" : "Dark Night"} ",
                    ),
                    Column(
                      children: [
                        Text(
                          "= ${_model.timeRequirePerSection.toStringAsFixed(2)} Section hours ",
                        ),
                        Text(
                          "= ${_model.totalTimeRequire.toStringAsFixed(2)} Platoon hours ",
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SectionHeading('3. ', "Manpower Calculation"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(1) ${_model.section}x section each having ${_model.task.nco} NCO and ${_model.task.men} men",
                    ),
                    Text(
                      "(2) This group will form ${_model.task.group}",
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
