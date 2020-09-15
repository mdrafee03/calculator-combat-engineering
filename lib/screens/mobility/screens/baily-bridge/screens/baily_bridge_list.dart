import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/list_builder.dart';
import '../../../models/mobility.dart';
import '../models/baily_bridge.dart';

class BailyBridgeList extends StatefulWidget {
  @override
  _BailyBridgeListState createState() => _BailyBridgeListState();
}

class _BailyBridgeListState extends State<BailyBridgeList> {
  final List<BailyBridge> _listOfBailyBridge = Mobility.listOfBailyBridge;

  @override
  Widget build(BuildContext context) {
    return ListBuilder(
      args: BailyBridge(),
      input: bailyBridgeInput,
      list: _listOfBailyBridge,
      output: bailyBridgeOutput,
      title: "Baily Bridge",
      onDelete: (int index) =>
          setState(() => _listOfBailyBridge.removeAt(index)),
    );
  }
}
