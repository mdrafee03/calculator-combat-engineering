import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
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

  final _footing = FootingPier();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, footingPierOutput, arguments: _footing);
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
                      setState(() => _footing.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness", labelText: "Thickness"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _footing.thickness = double.parse(val)),
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
