import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/list_builder.dart';
import '../../../models/reserve_demolition.dart';
import '../models/roadway.dart';

class RoadwayList extends StatefulWidget {
  @override
  _RoadwayListState createState() => _RoadwayListState();
}

class _RoadwayListState extends State<RoadwayList> {
  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    List<Roadway> _listOfRoadway = _currentReserveDemolition.listOfRoadway;
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
