import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/input_submit_button.dart';
import '../../../models/counter_mobility.dart';

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

  @override
  Widget build(BuildContext context) {
    AntiTank _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = CounterMobility.listOfAntiTank.contains(_model);
      if (isEdit == false) {
        CounterMobility.listOfAntiTank.add(_model);
      }
      Navigator.pushNamed(context, antiTankOuput, arguments: _model);
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
                      hintText: "Length of the Anti tank Ditch",
                      labelText: "Length of the Anti tank Ditch (yard)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.length != null ? _model.length.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.length = double.parse(val)),
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
