import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/reserve_demolition.dart';

class ReserveDemolitionList extends StatefulWidget {
  @override
  _ReserveDemolitionListState createState() => _ReserveDemolitionListState();
}

class _ReserveDemolitionListState extends State<ReserveDemolitionList> {
  final List<ReserveDemolition> _listOfReserveDemolition =
      CounterMobility.listOfReserveDemolition;
  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: ReserveDemolition(),
      input: reserveDemolitionChildren,
      list: _listOfReserveDemolition,
      title: "Reserve Demolition",
      onDelete: (int index) =>
          setState(() => _listOfReserveDemolition.removeAt(index)),
    );
  }
}
