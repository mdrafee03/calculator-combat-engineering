import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/borehole_charge_type.dart';
import '../models/borehole_charge.dart';

class BoreholeChargeInput extends StatefulWidget {
  @override
  _BoreholeChargeInputState createState() => _BoreholeChargeInputState();
}

class _BoreholeChargeInputState extends State<BoreholeChargeInput> {
  final appBar = AppBar(
    title: Text('Borehole Charge'),
  );

  ReserveDemolition _currentReserveDemolition;

  final _formKey = GlobalKey<FormState>();

  BoreholeCharge _model;

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, boreholeChargeOutput, arguments: _model);
  }

  @override
  Widget build(BuildContext context) {
    _currentReserveDemolition = ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.boreholeCharge != null) {
      _model = _currentReserveDemolition.pier.boreholeCharge;
    } else {
      _model = BoreholeCharge();
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      _currentReserveDemolition.pier.boreholeCharge = _model;
      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, boreholeChargeOutput, arguments: _model);
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
                      hintText: "Width", labelText: "Width (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.width != null ? _model.width.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness", labelText: "Thickness (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.thickness != null
                      ? _model.thickness.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.thickness = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of pier", labelText: "No of pier (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfPier != null
                      ? _model.noOfPier.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.noOfPier = int.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Pier',
                  hintText: 'Type of Pier',
                  value: _model.typeOfBoreholePier,
                  filled: false,
                  dataSource: BoreholeChargeType.typesOfBoreholePier
                      .map(
                          (option) => {"display": option.name, "value": option})
                      .toList(),
                  onChanged: (BoreholeChargeType value) {
                    setState(() {
                      _model.typeOfBoreholePier = value;
                      _model.row = value.row;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
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
