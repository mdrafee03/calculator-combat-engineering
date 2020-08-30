import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../models/span_beam_girder.dart';

class SpanBeamGirderInput extends StatefulWidget {
  @override
  _SpanBeamGirderInputState createState() => _SpanBeamGirderInputState();
}

class _SpanBeamGirderInputState extends State<SpanBeamGirderInput> {
  final appBar = AppBar(
    title: Text('Span, Beam and Girder'),
  );

  final _formKey = GlobalKey<FormState>();

  final SpanBeamGirder _model = SpanBeamGirder();

  void handleSubmit(BuildContext context) {
    final form = _formKey.currentState;
    form.save();
    Navigator.pushNamed(context, spanBeamGirderOutput, arguments: _model);
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
                      hintText: "Length of span",
                      labelText: "Length of span (ft)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.length = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of Rd/ Ht of the Roadway",
                      labelText: "Thickness of Rd/ Ht of the Roadway (inch)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfRoadway = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of beam",
                      labelText: "Thickness of beam (inch)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfBeam = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "height of the X girder",
                      labelText: "height of the X girder (inch)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.height = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Beams", labelText: "No of Beams (nos)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.noOfBeams = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Span", labelText: "No of Span (nos)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.noOfSpans = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Width of pier",
                      labelText: "Width of pier (ft)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
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
