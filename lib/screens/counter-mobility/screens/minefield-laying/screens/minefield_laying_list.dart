import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/minefield_laying.dart';

class MinefieldLayingList extends StatefulWidget {
  @override
  _MinefieldLayingListState createState() => _MinefieldLayingListState();
}

class _MinefieldLayingListState extends State<MinefieldLayingList> {
  final List<MinefieldLaying> _listOfMinefieldLaying =
      CounterMobility.listOfMinefieldLaying;

  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: MinefieldLaying(),
      input: minefieldLayingInput,
      list: _listOfMinefieldLaying,
      output: minefieldLayingOutput,
      title: "Minefield Laying",
      onDelete: (int index) =>
          setState(() => _listOfMinefieldLaying.removeAt(index)),
    );
  }
}
