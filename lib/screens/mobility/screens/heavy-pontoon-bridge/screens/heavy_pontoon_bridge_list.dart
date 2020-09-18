import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/mobility.dart';
import '../models/heavy_pontoon_bridge.dart';

class HeavyPontoonBridgeList extends StatefulWidget {
  @override
  _HeavyPontoonBridgeListState createState() => _HeavyPontoonBridgeListState();
}

class _HeavyPontoonBridgeListState extends State<HeavyPontoonBridgeList> {
  final List<HeavyPontoonBridge> _listOfHeavyPontoonBridge =
      Mobility.listOfHeavyPontoonBridge;

  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: HeavyPontoonBridge(),
      input: heavyPontoonBridgeInput,
      list: _listOfHeavyPontoonBridge,
      output: heavyPontoonBridgeOutput,
      title: "Heavy Pontoon Bridge",
      onDelete: (int index) =>
          setState(() => _listOfHeavyPontoonBridge.removeAt(index)),
    );
  }
}
