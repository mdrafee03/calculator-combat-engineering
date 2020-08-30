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

  final _model = FootingPier();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, footingPierOutput, arguments: _model);
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
                      hintText: "No of Pier", labelText: "No of Pier (nos)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.noOfPier = int.parse(val)),
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
