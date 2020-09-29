import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../../../models/counter_mobility.dart';
import '../../../../../models/reserve_demolition.dart';
import '../models/borehole_pier_type.dart';
import '../models/borehole_pier.dart';

class BoreholePierInput extends StatefulWidget {
  @override
  _BoreholePierInputState createState() => _BoreholePierInputState();
}

class _BoreholePierInputState extends State<BoreholePierInput> {
  final appBar = AppBar(
    title: Text('Borehole Charge'),
  );

  final _formKey = GlobalKey<FormState>();

  BoreholePier _model;

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, boreholePierOutput, arguments: _model);
  }

  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    if (_currentReserveDemolition?.pier?.boreholePier != null) {
      _model = _currentReserveDemolition.pier.boreholePier;
    } else {
      _model = BoreholePier();
      _currentReserveDemolition.pier.boreholePier = _model;
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, boreholePierOutput, arguments: _model);
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
                  dataSource: typesOfBoreholePier
                      .map(
                          (option) => {"display": option.name, "value": option})
                      .toList(),
                  onChanged: (BoreholePierType value) {
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
