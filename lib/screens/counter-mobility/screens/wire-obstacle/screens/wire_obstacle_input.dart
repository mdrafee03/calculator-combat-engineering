import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../models/wire_obstacle.dart';
import '../models/wire_obstacle_task.dart';

import 'package:combat_engineering/router/route_const.dart';

class WireObstacleInput extends StatefulWidget {
  @override
  _WireObstacleInputState createState() => _WireObstacleInputState();
}

class _WireObstacleInputState extends State<WireObstacleInput> {
  final appBar = AppBar(
    title: Text('Wire Obstacle'),
  );

  final _formKey = GlobalKey<FormState>();

  final _model = WireObstacle();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, wireObstacleOuput, arguments: _model);
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
                      hintText: "Frontage", labelText: "Frontage (yard)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.frontage = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Section", labelText: "Section (nos)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.section = int.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Time',
                  hintText: 'Time',
                  value: _model.time,
                  filled: false,
                  dataSource: [
                    {"display": "Day", "value": PartsOfDay.Day},
                    {"display": "Dark Night", "value": PartsOfDay.Night}
                  ],
                  onChanged: (PartsOfDay value) {
                    setState(() {
                      _model.time = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'Type of Wire Obstacle',
                  hintText: 'Type of Wire Obstacle',
                  value: _model.task,
                  filled: false,
                  dataSource: listOfWireObstackleTasks
                      .map(
                          (option) => {"display": option.task, "value": option})
                      .toList(),
                  onChanged: (WireObstacleTask value) {
                    setState(() {
                      _model.task = value;
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
