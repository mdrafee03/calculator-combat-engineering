import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
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

  final _shaped = ShapedPier();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, shapedPierOutput, arguments: _shaped);
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
                      hintText: "Dia of each Pier",
                      labelText: "Dia of each Pier"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _shaped.dia = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Pier", labelText: "No of Pier"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _shaped.noOfPier = int.parse(val)),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       hintText: "No of pier", labelText: "No of pier"),
                //   keyboardType: TextInputType.number,
                //   onSaved: (val) =>
                //       setState(() => _shaped.noOfPier = int.parse(val)),
                // ),
                // DropDownFormField(
                //   titleText: 'Type of Pier',
                //   hintText: 'Type of Pier',
                //   value: _shaped.typeOfBoreholePier,
                //   filled: false,
                //   dataSource: typesOfBoreholePier
                //       .map(
                //           (option) => {"display": option.name, "value": option})
                //       .toList(),
                //   onChanged: (BoreholePierType value) {
                //     setState(() {
                //       _shaped.typeOfBoreholePier = value;
                //       _shaped.row = value.row;
                //     });
                //   },
                //   textField: 'display',
                //   valueField: 'value',
                // ),
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
