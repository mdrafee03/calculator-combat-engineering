import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/input_submit_button.dart';
import '../../../../../models/counter_mobility.dart';
import '../../../models/reserve_demolition.dart';
import '../models/roadway.dart';

class RoadwayInput extends StatefulWidget {
  @override
  _RoadwayInputState createState() => _RoadwayInputState();
}

class _RoadwayInputState extends State<RoadwayInput> {
  final appBar = AppBar(
    title: Text('Demolition of Roadway'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Roadway _model = ModalRoute.of(context).settings.arguments;
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;

    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();

      if (_currentReserveDemolition.listOfRoadway.contains(_model) == false)
        _currentReserveDemolition.listOfRoadway.add(_model);

      if (CounterMobility.listOfReserveDemolition
              .contains(_currentReserveDemolition) ==
          false)
        CounterMobility.listOfReserveDemolition.add(_currentReserveDemolition);
      Navigator.pushNamed(context, roadwayOutput, arguments: _model);
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
                      hintText: "width of the road",
                      labelText: "width of the road (ft)"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.width != null ? _model.width.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.width = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "length of the road",
                      labelText: "length of road (m)"),
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
