import 'package:combat_engineering/router/route_const.dart';
import 'package:combat_engineering/screens/counter-mobility/screens/reserve-demolition/screens/span-roadway/models/span_roadway.dart';
import 'package:flutter/material.dart';

class SpanRoadwayInput extends StatefulWidget {
  @override
  _SpanRoadwayInputState createState() => _SpanRoadwayInputState();
}

class _SpanRoadwayInputState extends State<SpanRoadwayInput> {
  final appBar = AppBar(
    title: Text('Demolition of Span or Roadway'),
  );

  final _formKey = GlobalKey<FormState>();

  final SpanRoadway _model = SpanRoadway();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, spanRoadwayOutput, arguments: _model);
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
                      hintText: "Length of span", labelText: "Length of span"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.length = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of Rd/ Ht of the Roadway",
                      labelText: "Thickness of Rd/ Ht of the Roadway"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfRoadway = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of beam",
                      labelText: "Thickness of beam"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfBeam = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "height of the X girder",
                      labelText: "height of the X girder"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.height = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Beams", labelText: "No of Beams"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.noOfBeams = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Span", labelText: "No of Span"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.noOfSpans = int.parse(val)),
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
