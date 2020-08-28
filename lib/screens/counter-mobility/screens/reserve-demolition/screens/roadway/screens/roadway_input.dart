import 'package:combat_engineering/router/route_const.dart';
import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/roadway/models/roadway.dart';
import 'package:flutter/material.dart';

class RoadwayInput extends StatefulWidget {
  @override
  _RoadwayInputState createState() => _RoadwayInputState();
}

class _RoadwayInputState extends State<RoadwayInput> {
  final appBar = AppBar(
    title: Text('Demolition of Roadway'),
  );

  final _formKey = GlobalKey<FormState>();

  final _model = Roadway();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, roadwayOutput, arguments: _model);
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
                      hintText: "width of the road",
                      labelText: "width of the road"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "length of the road",
                      labelText: "length of road "),
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
