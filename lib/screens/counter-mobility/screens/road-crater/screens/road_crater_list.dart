import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/road_crater.dart';

class RoadCraterList extends StatefulWidget {
  @override
  _RoadCraterListState createState() => _RoadCraterListState();
}

class _RoadCraterListState extends State<RoadCraterList> {
  @override
  Widget build(BuildContext context) {
    final List<RoadCrater> _listOfRoadCrater = CounterMobility.listOfRoadCrater;
    return ListBuilder(
      args: RoadCrater(),
      input: roadCraterInput,
      list: _listOfRoadCrater,
      output: roadCraterOutput,
      title: "Road Crater",
      onDelete: (int index) =>
          setState(() => _listOfRoadCrater.removeAt(index)),
    );
  }
}
