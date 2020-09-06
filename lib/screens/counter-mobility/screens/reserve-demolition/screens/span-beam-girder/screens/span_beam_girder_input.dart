import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../models/counter_mobility.dart';
import '../../../models/reserve_demolition.dart';
import '../models/span_beam_girder.dart';

class SpanBeamGirderInput extends StatefulWidget {
  @override
  _SpanBeamGirderInputState createState() => _SpanBeamGirderInputState();
}

class _SpanBeamGirderInputState extends State<SpanBeamGirderInput> {
  final appBar = AppBar(
    title: Text('Span, Beam and Girder Demolition'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    SpanBeamGirder _model;
    if (_currentReserveDemolition.spanBeamGirder != null) {
      _model = _currentReserveDemolition.spanBeamGirder;
    } else {
      _model = SpanBeamGirder();
      _currentReserveDemolition.spanBeamGirder = _model;
    }

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, spanBeamGirderOutput, arguments: _model);
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
                      hintText: "Length of span",
                      labelText: "Length of span (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.length != null ? _model.length.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.length = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of Rd/ Ht of the Roadway",
                      labelText: "Thickness of Rd/ Ht of the Roadway (inch)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.thicknessOfRoadway != null
                      ? _model.thicknessOfRoadway.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfRoadway = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Thickness of beam",
                      labelText: "Thickness of beam (inch)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.thicknessOfBeam != null
                      ? _model.thicknessOfBeam.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.thicknessOfBeam = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "height of the X girder",
                      labelText: "height of the X girder (inch)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.height != null ? _model.height.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.height = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Beams", labelText: "No of Beams (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfBeams != null
                      ? _model.noOfBeams.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.noOfBeams = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "No of Span", labelText: "No of Span (nos)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfSpans != null
                      ? _model.noOfSpans.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.noOfSpans = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Width of pier",
                      labelText: "Width of pier (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.width != null ? _model.width.toString() : null,
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
