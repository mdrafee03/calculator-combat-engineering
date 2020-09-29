import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/shaped_pier.dart';

class ShapedPierInput extends StatefulWidget {
  @override
  _ShapedPierInputState createState() => _ShapedPierInputState();
}

class _ShapedPierInputState extends State<ShapedPierInput> {
  final appBar = AppBar(
    title: Text('Shaped Charge'),
  );

  final _formKey = GlobalKey<FormState>();
  ShapedPier _model;

  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.shapedPier != null) {
      _model = _currentReserveDemolition.pier.shapedPier;
    } else {
      _model = ShapedPier();
      _currentReserveDemolition.pier.shapedPier = _model;
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, shapedPierOutput, arguments: _model);
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
