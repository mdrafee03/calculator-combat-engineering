import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/pier_footing_charge.dart';

class PierFootingChargeInput extends StatefulWidget {
  @override
  _FootingState createState() => _FootingState();
}

class _FootingState extends State<PierFootingChargeInput> {
  final appBar = AppBar(
    title: Text('Pier Footing Charge'),
  );
  ReserveDemolition _currentReserveDemolition;
  final _formKey = GlobalKey<FormState>();
  PierFootingCharge _model;

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, pierFootingChargeOutput, arguments: _model);
  }

  @override
  Widget build(BuildContext context) {
    _currentReserveDemolition = ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.pierFootingCharge != null) {
      _model = _currentReserveDemolition.pier.pierFootingCharge;
    } else {
      _model = PierFootingCharge();
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      _currentReserveDemolition.pier.pierFootingCharge = _model;

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, pierFootingChargeOutput, arguments: _model);
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
