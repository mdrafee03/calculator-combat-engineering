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
    title: Text('Abutment'),
  );

  final _formKey = GlobalKey<FormState>();

  final _borehole = BoreholePier();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, boreholePierOutput, arguments: _borehole);
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
                      setState(() => _borehole.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness", labelText: "Thickness"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _borehole.thickness = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of pier", labelText: "No of pier"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _borehole.noOfPier = int.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Pier',
                  hintText: 'Type of Pier',
                  value: _borehole.typeOfBoreholePier,
                  filled: false,
                  dataSource: typesOfBoreholePier
                      .map(
                          (option) => {"display": option.name, "value": option})
                      .toList(),
                  onChanged: (BoreholePierType value) {
                    setState(() {
                      _borehole.typeOfBoreholePier = value;
                      _borehole.row = value.row;
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
