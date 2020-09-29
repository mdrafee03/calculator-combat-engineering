import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/wire_obstacle.dart';

class WireObstacleList extends StatefulWidget {
  @override
  _WireObstacleListState createState() => _WireObstacleListState();
}

class _WireObstacleListState extends State<WireObstacleList> {
  final List<WireObstacle> _listOfWireObstacle =
      CounterMobility.listOfWireObstacle;

  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: WireObstacle(),
      input: wireObstacleInput,
      list: _listOfWireObstacle,
      output: wireObstacleOuput,
      title: "Wire Obstacle",
      onDelete: (int index) =>
          setState(() => _listOfWireObstacle.removeAt(index)),
    );
  }
}
