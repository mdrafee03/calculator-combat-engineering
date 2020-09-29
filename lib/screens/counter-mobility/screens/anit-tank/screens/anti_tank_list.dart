import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/counter_mobility.dart';
import '../models/anti_tank.dart';

class AntiTankList extends StatefulWidget {
  @override
  _AntiTankListState createState() => _AntiTankListState();
}

class _AntiTankListState extends State<AntiTankList> {
  final List<AntiTank> _listOfAntiTank = CounterMobility.listOfAntiTank;
  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: AntiTank(),
      input: antiTankInput,
      list: _listOfAntiTank,
      output: antiTankOuput,
      title: "Anti Tank Ditch",
      onDelete: (int index) => setState(() => _listOfAntiTank.removeAt(index)),
    );
  }
}
