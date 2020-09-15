import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/mobility.dart';
import '../models/baily_bridge.dart';

class BailyBridgeInput extends StatefulWidget {
  @override
  _BailyBridgeInputState createState() => _BailyBridgeInputState();
}

class _BailyBridgeInputState extends State<BailyBridgeInput> {
  final appBar = AppBar(
    title: Text('Baily Bridge'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BailyBridge _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = Mobility.listOfBailyBridge.contains(_model);
      if (isEdit == false) {
        Mobility.listOfBailyBridge.add(_model);
      }
      Navigator.pushNamed(context, bailyBridgeOutput, arguments: _model);
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
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Water Gap", labelText: "Water Gap (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.waterGap?.toString() ?? null,
                  onSaved: (val) =>
                      setState(() => _model.waterGap = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Distance between Launching and Landing Roller",
                      labelText:
                          "Distance between Launching and Landing Roller (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model?.distanceBtweenLaunchingLanding?.toString() ??
                          null,
                  onSaved: (val) => setState(() => _model
                      .distanceBtweenLaunchingLanding = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Load Classification",
                      labelText: "Load Classification (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.loadClassification?.toString() ?? null,
                  onSaved: (val) => setState(
                      () => _model.loadClassification = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Pressure of Soil",
                      labelText: "Pressure of Soil (ton/sq ft)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.pressureOfSoil?.toString() ?? null,
                  onSaved: (val) =>
                      setState(() => _model.pressureOfSoil = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Additional Grillage Require",
                    labelText: "Additional Grillage Require (Nos)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.additionalGrillage?.toString() ?? null,
                  onSaved: (val) => setState(
                      () => _model.additionalGrillage = int.parse(val)),
                ),
                // DropDownFormField(
                //   titleText: 'Time',
                //   hintText: 'Time',
                //   value: _model.time,
                //   filled: false,
                //   dataSource: [
                //     {"display": "Day", "value": PartsOfDay.Day},
                //     {"display": "Dark Night", "value": PartsOfDay.Night}
                //   ],
                //   onChanged: (PartsOfDay value) {
                //     setState(() {
                //       _model.time = value;
                //     });
                //   },
                //   textField: 'display',
                //   valueField: 'value',
                // ),
                // DropDownFormField(
                //   titleText: 'Type of Wire Obstacle',
                //   hintText: 'Type of Wire Obstacle',
                //   value: _model.task,
                //   filled: false,
                //   dataSource: listOfWireObstackleTasks
                //       .map(
                //           (option) => {"display": option.task, "value": option})
                //       .toList(),
                //   onChanged: (WireObstacleTask value) {
                //     setState(() {
                //       _model.task = value;
                //     });
                //   },
                //   textField: 'display',
                //   valueField: 'value',
                // ),
                RaisedButton(
                  onPressed: () => handleSubmit(context),
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
