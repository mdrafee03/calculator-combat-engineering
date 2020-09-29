import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/input_submit_button.dart';
import '../../../models/mobility.dart';
import '../models/heavy_pontoon_bridge.dart';

class HeavyPontoonBridgeInput extends StatefulWidget {
  @override
  _HeavyPontoonBridgeInputState createState() =>
      _HeavyPontoonBridgeInputState();
}

class _HeavyPontoonBridgeInputState extends State<HeavyPontoonBridgeInput> {
  final appBar = AppBar(
    title: Text('Heavy Pontoon Bridge'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HeavyPontoonBridge _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = Mobility.listOfHeavyPontoonBridge.contains(_model);
      if (isEdit == false) {
        Mobility.listOfHeavyPontoonBridge.add(_model);
      }
      Navigator.pushNamed(context, heavyPontoonBridgeOutput, arguments: _model);
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropDownFormField(
                  titleText: 'Floating Bridge Classification',
                  hintText: 'Floating Bridge Classification',
                  value: _model.classification,
                  filled: false,
                  dataSource: [
                    {"display": "25 Ton", "value": 1},
                    {"display": "50 Ton", "value": 2}
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _model.classification = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'No of lanes in floating bridge',
                  hintText: 'No of lanes in floating bridge',
                  value: _model.numberOfLanes,
                  filled: false,
                  dataSource: [
                    {"display": "Single Lane", "value": 1},
                    {"display": "Double Lane", "value": 2}
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _model.numberOfLanes = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "River Width", labelText: "River Width (m)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.riverWidth?.toString() ?? null,
                  onChanged: (value) =>
                      setState(() => _model.riverWidth = double.parse(value)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Current Velocity",
                      labelText: "Current Velocity (m)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.currentVelocity?.toString() ?? null,
                  onChanged: (value) => setState(
                      () => _model.currentVelocity = double.parse(value)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "Distance between near shore to 0.8m depth point",
                      labelText:
                          "Distance between near shore to 0.8m depth point (m)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.distanceNearShore?.toString() ?? null,
                  onChanged: (value) => setState(
                      () => _model.distanceNearShore = double.parse(value)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "Distance between far shore to 0.8m depth point",
                      labelText:
                          "Distance between far shore to 0.8m depth point (m)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.distanceFarShore?.toString() ?? null,
                  onChanged: (value) => setState(
                      () => _model.distanceFarShore = double.parse(value)),
                ),
                InputSubmitButton(handleSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
