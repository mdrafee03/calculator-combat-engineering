import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
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

  final _model = BoreholePier();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, boreholePierOutput, arguments: _model);
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
                  decoration: InputDecoration(
                      hintText: "Width", labelText: "Width (ft)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness", labelText: "Thickness (ft)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.thickness = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of pier", labelText: "No of pier (nos)"),
                  keyboardType: TextInputType.number,
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
