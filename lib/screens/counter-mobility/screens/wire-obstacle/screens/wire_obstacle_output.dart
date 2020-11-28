import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../models/wire_obstacle.dart';

class WireObstacleOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WireObstacle _model = ModalRoute.of(context).settings.arguments;
    final AppBar appbar = AppBar(
      title: Text('Wire Obstacle'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              wireObstacleList,
              ModalRoute.withName(counterMobilityScreen),
            );
          },
        ),
        if (Platform.isAndroid)
          Builder(builder: (BuildContext ctx) {
            return IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () => _model.savePDF(ctx),
            );
          }),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _model.sharePDF(),
        )
      ],
    );
    _model.sl = 0;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TopHeader('Summary of Wire Obstacle'),
              SectionHeading('1. ', "Store Calculation"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_model.getSerial}. Barbed wire = ${_model.getValueByFrontage(_model.task.barbedWire)} Nos",
                    ),
                    if ([2, 3, 4, 5, 6].contains(_model.task.id))
                      Text(
                        "${_model.getSerial}. Barbed wire concertina = ${_model.getValueByFrontage(_model.task.barbedWireConcertina)} Nos",
                      ),
                    Text(
                      "${_model.getSerial}. Long Piquet = ${_model.getValueByFrontage(_model.task.longPicket)} Nos",
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
              SectionHeading('4. ', "Layout of ${_model.task.task}"),
              Column(
                children: _model.task.images.map((item) {
                  return Container(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
