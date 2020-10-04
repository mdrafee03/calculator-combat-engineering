import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/roadway.dart';

class RoadwayList extends StatefulWidget {
  @override
  _RoadwayListState createState() => _RoadwayListState();
}

class _RoadwayListState extends State<RoadwayList> {
  @override
  Widget build(BuildContext context) {
    final List<Roadway> _listOfRoadway = CounterMobility.listOfRoadway;
    return ListBuilder(
      args: Roadway(),
      input: roadwayInput,
      list: _listOfRoadway,
      output: roadwayOutput,
      title: "Roadway",
      onDelete: (int index) => setState(() => _listOfRoadway.removeAt(index)),
    );
  }
}
