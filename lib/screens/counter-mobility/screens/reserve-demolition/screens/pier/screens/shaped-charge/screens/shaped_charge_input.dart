import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/shaped_charge.dart';

class ShapedChargeInput extends StatefulWidget {
  @override
  _ShapedChargeInputState createState() => _ShapedChargeInputState();
}

class _ShapedChargeInputState extends State<ShapedChargeInput> {
  final appBar = AppBar(
    title: Text('Shaped Charge'),
  );
  ReserveDemolition _currentReserveDemolition;
  final _formKey = GlobalKey<FormState>();
  ShapedCharge _model;

  @override
  Widget build(BuildContext context) {
    _currentReserveDemolition = ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.shapedCharge != null) {
      _model = _currentReserveDemolition.pier.shapedCharge;
    } else {
      _model = ShapedCharge();
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      _currentReserveDemolition.pier.shapedCharge = _model;
      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, shapedChargeOutput, arguments: _model);
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
                      hintText: "Dia of each Pier",
                      labelText: "Dia of each Pier (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.dia != null ? _model.dia.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.dia = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Pier", labelText: "No of Pier (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfPier != null
                      ? _model.noOfPier.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.noOfPier = int.parse(val)),
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
