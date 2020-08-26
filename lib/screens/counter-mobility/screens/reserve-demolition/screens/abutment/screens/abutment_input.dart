import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../models/abutment.dart';
import '../../../../../../../router/route_const.dart';

class AbutmentInput extends StatefulWidget {
  @override
  _AbutmentInputState createState() => _AbutmentInputState();
}

class _AbutmentInputState extends State<AbutmentInput> {
  final appBar = AppBar(
    title: Text('Abutment'),
  );

  final _formKey = GlobalKey<FormState>();

  final _abutment = Abutment();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, abutmentOutput, arguments: _abutment);
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration:
                      InputDecoration(hintText: "Width", labelText: "Width"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _abutment.width = double.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Target',
                  hintText: 'Type of Target',
                  value: _abutment.targetFactor,
                  filled: false,
                  dataSource: typesOfTarget
                      .map((option) =>
                          {"display": option['type'], "value": option['value']})
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      _abutment.targetFactor = value.toDouble();
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Crater", labelText: "Crater"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _abutment.craterNo = int.parse(val)),
                ),
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
