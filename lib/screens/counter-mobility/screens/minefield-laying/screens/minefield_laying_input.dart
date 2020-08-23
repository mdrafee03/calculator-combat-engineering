import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../models/minefield_laying.dart';

class MineFieldLayingInput extends StatefulWidget {
  @override
  _MinefieldLayingInputState createState() => _MinefieldLayingInputState();
}

class _MinefieldLayingInputState extends State<MineFieldLayingInput> {
  final appBar = AppBar(
    title: Text('Minefield Laying'),
  );

  final _formKey = GlobalKey<FormState>();

  final _minefieldLaying = MinefieldLaying();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, minefieldLayingOutput,
        arguments: _minefieldLaying);
    print(_minefieldLaying.numberOfClusterPerStrip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Frontage", labelText: "Frontage"),
                keyboardType: TextInputType.number,
                onSaved: (val) => setState(() => _minefieldLaying.frontage =
                    _minefieldLaying.convertToFraction(val)),
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Density", labelText: "Density"),
                keyboardType: TextInputType.number,
                onSaved: (val) => setState(
                  () => _minefieldLaying.density =
                      _minefieldLaying.convertToFraction(val),
                ),
              ),
              RaisedButton(
                onPressed: () => handleSubmit(context),
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
