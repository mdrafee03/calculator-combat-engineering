import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/mobility.dart';
import '../models/minefield_breaching.dart';

class MinefieldBreachingInput extends StatefulWidget {
  @override
  _MinefieldBreachingInputState createState() =>
      _MinefieldBreachingInputState();
}

class _MinefieldBreachingInputState extends State<MinefieldBreachingInput> {
  final appBar = AppBar(
    title: Text('Heavy Pontoon Bridge'),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MinefieldBreaching _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = Mobility.listOfMinefieldBreaching.contains(_model);
      if (isEdit == false) {
        Mobility.listOfMinefieldBreaching.add(_model);
      }
      Navigator.pushNamed(context, minefieldBreachingOutput, arguments: _model);
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
                    hintText: "Density",
                    labelText: "Density (yard)",
                  ),
                  initialValue: _model?.density?.toString() ?? null,
                  onSaved: (val) => setState(
                    () => _model.density = _model.convertToFraction(val),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Braching Lane Depth",
                    labelText: "Breaching Lane Depth (yard)",
                  ),
                  initialValue: _model?.branchingLaneDepth?.toString() ?? null,
                  onSaved: (val) => setState(
                    () => _model.branchingLaneDepth = int.parse(val),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Rest Time",
                    labelText: "Rest Time (min)",
                  ),
                  initialValue: _model?.restTime?.toString() ?? null,
                  onSaved: (val) => setState(
                    () => _model.restTime = int.parse(val),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Number of Field Engineer platoon",
                    labelText: "Number of Field Engineer platoon (Nos)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model?.noOfFieldEngineerPlatoon?.toString() ?? null,
                  onSaved: (val) => setState(
                      () => _model.noOfFieldEngineerPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Number of Infantry platoon",
                    labelText: "Number of Infantry platoon (Nos)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _model?.noOfInfantryPlatoon?.toString() ?? null,
                  onSaved: (val) => setState(
                      () => _model.noOfInfantryPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Number of Assault Pioneer platoon",
                    labelText: "Number of Assault Pioneer platoon (Nos)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model?.noOfAssaultPioneerPlatoon?.toString() ?? null,
                  onSaved: (val) => setState(
                      () => _model.noOfAssaultPioneerPlatoon = int.parse(val)),
                ),
                ListTile(
                  title: Text(
                    "First Light: ${_model.firstLight.format(context)}",
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    TimeOfDay t = await showTimePicker(
                      context: context,
                      initialTime: _model.firstLight,
                    );
                    if (t != null) {
                      setState(() {
                        _model.firstLight = t;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "Last Light: ${_model.lastLight.format(context)}",
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    TimeOfDay t = await showTimePicker(
                      context: context,
                      initialTime: _model.lastLight,
                    );
                    if (t != null) {
                      setState(() {
                        _model.lastLight = t;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "Start Time: ${_model.startTime.format(context)}",
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    TimeOfDay t = await showTimePicker(
                      context: context,
                      initialTime: _model.startTime,
                    );
                    if (t != null) {
                      setState(() {
                        _model.startTime = t;
                      });
                    }
                  },
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
