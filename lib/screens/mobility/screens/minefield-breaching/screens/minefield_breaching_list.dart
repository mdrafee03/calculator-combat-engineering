import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/mobility.dart';
import '../models/minefield_breaching.dart';

class MinefieldBreachingList extends StatefulWidget {
  @override
  _MinefieldBreachingListState createState() => _MinefieldBreachingListState();
}

class _MinefieldBreachingListState extends State<MinefieldBreachingList> {
  final List<MinefieldBreaching> _listOfMinefieldBreaching =
      Mobility.listOfMinefieldBreaching;

  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: MinefieldBreaching(),
      input: minefieldBreachingInput,
      list: _listOfMinefieldBreaching,
      output: minefieldBreachingOutput,
      title: "Minefield Breaching",
      onDelete: (int index) =>
          setState(() => _listOfMinefieldBreaching.removeAt(index)),
    );
  }
}
