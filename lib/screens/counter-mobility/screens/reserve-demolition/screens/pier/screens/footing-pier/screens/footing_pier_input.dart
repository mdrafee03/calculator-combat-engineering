import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/footing_pier.dart';

class FootingPierInput extends StatefulWidget {
  @override
  _FootingState createState() => _FootingState();
}

class _FootingState extends State<FootingPierInput> {
  final appBar = AppBar(
    title: Text('Pier Footing Charge'),
  );

  final _formKey = GlobalKey<FormState>();

  FootingPier _model;

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, footingPierOutput, arguments: _model);
  }

  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.footingPier != null) {
      _model = _currentReserveDemolition.pier.footingPier;
    } else {
      _model = FootingPier();
      _currentReserveDemolition.pier.footingPier = _model;
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, footingPierOutput, arguments: _model);
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
