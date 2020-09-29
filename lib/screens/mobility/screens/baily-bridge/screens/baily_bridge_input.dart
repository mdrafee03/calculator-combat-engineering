import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/input_submit_button.dart';
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

    TextFormField buildFieldForGroundLevel(
        Map<PositionRollers, double> groundLevel, PositionRollers element) {
      return TextFormField(
        key: ValueKey(element),
        decoration: InputDecoration(
          hintText:
              "Existing Ground level at ${_model.positionRollersString[element]}'",
          labelText:
              "Existing Ground level at ${_model.positionRollersString[element]} (inch)",
        ),
        keyboardType: TextInputType.number,
        initialValue:
            groundLevel[element] != 0 ? groundLevel[element].toString() : "",
        onChanged: (val) =>
            setState(() => groundLevel[element] = double.parse(val)),
      );
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
                    onChanged: (value) =>
                        setState(() => _model.waterGap = double.parse(value))),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "Distance of Launching roller from the near bank",
                      labelText:
                          "Distance of Launching roller from the near bank (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model?.distanceBetweenLaunchingNearbank?.toString() ??
                          null,
                  onChanged: (value) => setState(() => _model
                      .distanceBetweenLaunchingNearbank = double.parse(value)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Distance of Landing roller from the far bank",
                      labelText:
                          "Distance of Landing roller from the far bank (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model?.distanceBetweenLandingFarbank?.toString() ?? null,
                  onChanged: (value) => setState(() => _model
                      .distanceBetweenLandingFarbank = double.parse(value)),
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
                DropDownFormField(
                  titleText: 'Choose Launching Type',
                  hintText: 'Choose Launching Type',
                  value: _model.isLunching,
                  filled: false,
                  dataSource: [
                    {"display": "With Launching Calculation", "value": true},
                    {"display": "Withoug Launching Calculation", "value": false}
                  ],
                  onChanged: (bool value) {
                    setState(() {
                      _model.isLunching = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                if (_model.isLunching)
                  Column(
                    children: [
                      if (_model.positionOfConstructionRoller
                          .contains(PositionRollers.Roller102))
                        buildFieldForGroundLevel(
                          _model.existingGroundLevels,
                          PositionRollers.Roller102,
                        ),
                      if (_model.positionOfConstructionRoller
                          .contains(PositionRollers.Roller77))
                        buildFieldForGroundLevel(
                          _model.existingGroundLevels,
                          PositionRollers.Roller77,
                        ),
                      buildFieldForGroundLevel(
                        _model.existingGroundLevels,
                        PositionRollers.Roller52,
                      ),
                      buildFieldForGroundLevel(
                        _model.existingGroundLevels,
                        PositionRollers.Roller27,
                      ),
                      buildFieldForGroundLevel(
                        _model.existingGroundLevels,
                        PositionRollers.Roller3p5,
                      ),
                      buildFieldForGroundLevel(
                        _model.existingGroundLevels,
                        PositionRollers.Roller0,
                      ),
                      buildFieldForGroundLevel(
                        _model.existingGroundLevels,
                        PositionRollers.FarBank,
                      ),
                    ],
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
