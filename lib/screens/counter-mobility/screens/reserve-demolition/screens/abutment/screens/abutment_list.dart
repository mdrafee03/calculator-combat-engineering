import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/list_builder.dart';
import '../../../models/reserve_demolition.dart';
import '../models/abutment.dart';

class AbutmentList extends StatefulWidget {
  @override
  _AbutmentListState createState() => _AbutmentListState();
}

class _AbutmentListState extends State<AbutmentList> {
  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    List<Abutment> _listOfAbutment = _currentReserveDemolition.listOfAbutment;

    return ListBuilder(
      args: Abutment(),
      input: abutmentInput,
      list: _listOfAbutment,
      output: abutmentOutput,
      title: "Abutment",
      onDelete: (int index) => setState(() => _listOfAbutment.removeAt(index)),
    );
  }
}
