import 'package:flutter/material.dart';
import 'package:combat_engineering/router/route_const.dart';

import '../models/anti_tank.dart';

class AntiTankInput extends StatefulWidget {
  @override
  _AntiTankInputState createState() => _AntiTankInputState();
}

class _AntiTankInputState extends State<AntiTankInput> {
  final appBar = AppBar(
    title: Text('Anti Tank Ditch'),
  );

  final _formKey = GlobalKey<FormState>();

  final _model = AntiTank();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, antiTankOuput, arguments: _model);
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
                      hintText: "Length of the Anti tank Ditch",
                      labelText: "Length of the Anti tank Ditch (yard)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.length = double.parse(val)),
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
