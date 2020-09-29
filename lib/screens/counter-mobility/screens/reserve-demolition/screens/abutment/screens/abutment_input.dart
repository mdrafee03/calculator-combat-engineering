import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../models/counter_mobility.dart';
import '../../../models/reserve_demolition.dart';
import '../models/abutment.dart';

class AbutmentInput extends StatefulWidget {
  @override
  _AbutmentInputState createState() => _AbutmentInputState();
}

class _AbutmentInputState extends State<AbutmentInput> {
  final appBar = AppBar(
    title: Text('Abutment Demolition'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Abutment _model = ModalRoute.of(context).settings.arguments;
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      if (_currentReserveDemolition.listOfAbutment.contains(_model) == false)
        _currentReserveDemolition.listOfAbutment.add(_model);

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, abutmentOutput, arguments: _model);
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
                      hintText: "Width", labelText: "Width(ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.width != null ? _model.width.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Crater", labelText: "Crater (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.craterNo != null
                      ? _model.craterNo.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.craterNo = int.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Target',
                  hintText: 'Type of Target',
                  value: _model.targetFactor,
                  filled: false,
                  dataSource: typesOfTarget
                      .map((option) =>
                          {"display": option['type'], "value": option['value']})
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      _model.targetFactor = value.toDouble();
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
