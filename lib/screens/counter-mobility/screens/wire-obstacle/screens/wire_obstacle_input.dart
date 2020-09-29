import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/input_submit_button.dart';
import '../../../models/counter_mobility.dart';
import '../models/wire_obstacle.dart';
import '../models/wire_obstacle_task.dart';

class WireObstacleInput extends StatefulWidget {
  @override
  _WireObstacleInputState createState() => _WireObstacleInputState();
}

class _WireObstacleInputState extends State<WireObstacleInput> {
  final appBar = AppBar(
    title: Text('Wire Obstacle'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WireObstacle _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = CounterMobility.listOfWireObstacle.contains(_model);
      if (isEdit == false) {
        CounterMobility.listOfWireObstacle.add(_model);
      }
      Navigator.pushNamed(context, wireObstacleOuput, arguments: _model);
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
                      hintText: "Frontage", labelText: "Frontage (yard)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.frontage != null
                      ? _model.frontage.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.frontage = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Section", labelText: "Section (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.section != null ? _model.section.toString() : null,
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
                InputSubmitButton(handleSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
