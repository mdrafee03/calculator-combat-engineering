import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/input_submit_button.dart';
import '../../../models/counter_mobility.dart';
import '../models/moon_lit.dart';
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

  @override
  Widget build(BuildContext context) {
    MinefieldLaying _model = ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isEdit = CounterMobility.listOfMinefieldLaying.contains(_model);
      if (isEdit == false) {
        CounterMobility.listOfMinefieldLaying.add(_model);
      }
      Navigator.pushNamed(context, minefieldLayingOutput, arguments: _model);
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
                    hintText: "Frontage",
                    labelText: "Frontage",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _model.frontage != null
                      ? _model.frontage.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.frontage = double.parse(val)),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Depth", labelText: "Depth"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _model.depth != null ? _model.depth.toString() : null,
                  onSaved: (val) =>
                      setState(() => _model.depth = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Density", labelText: "Density"),
                  initialValue:
                      _model.density != null ? _model.density.toString() : null,
                  onSaved: (val) => setState(
                    () => _model.density = _model.convertToFraction(val),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of mixed strip",
                      labelText: "Number of mixed strip"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.numberOfMixedStrip != null
                      ? _model.numberOfMixedStrip.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.numberOfMixedStrip = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of IOE group",
                      labelText: "Number of IOE group"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.numberOfIOEGroup != null
                      ? _model.numberOfIOEGroup.toString()
                      : null,
                  onSaved: (val) =>
                      setState(() => _model.numberOfIOEGroup = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Cluster per group",
                      labelText: "Number of Cluster per group"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.numberOfClusterPerGroup != null
                      ? _model.numberOfClusterPerGroup.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.numberOfClusterPerGroup = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Total turning points",
                      labelText: "Total turning points (TP) (per strip)"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.totalTurningPointsPerStrip != null
                      ? _model.totalTurningPointsPerStrip.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.totalTurningPointsPerStrip = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Field Engineer platoon",
                      labelText: "Number of Field Engineer platoon"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfFieldEngineerPlatoon != null
                      ? _model.noOfFieldEngineerPlatoon.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.noOfFieldEngineerPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Infantry platoon",
                      labelText: "Number of Infantry platoon"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfInfantryPlatoon != null
                      ? _model.noOfInfantryPlatoon.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.noOfInfantryPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "No of Engineer Platoon Assisted By Infantry platoon",
                      labelText:
                          "No of Engineer Platoon Assisted By Infantry platoon"),
                  keyboardType: TextInputType.number,
                  initialValue: _model.noOfAssistedByInfantryPlatoon != null
                      ? _model.noOfAssistedByInfantryPlatoon.toString()
                      : null,
                  onSaved: (val) => setState(() =>
                      _model.noOfAssistedByInfantryPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Trip Wire of Mixed Cluster",
                    labelText: "Trip Wire of Mixed Cluster (%)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _model.percentageOfTripWire != null
                      ? _model.percentageOfTripWire.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _model.percentageOfTripWire = double.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Anti Tank Mine',
                  hintText: 'Type of Anti Tank Mine',
                  value: _model.noOfantiTankMinePerLorry,
                  filled: false,
                  dataSource: [
                    {
                      "display": "Anti Tank Mine Mark V",
                      "value": 440,
                    },
                    {
                      "display": "Anti Tank Mine Mark VII",
                      "value": 180,
                    },
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _model.noOfantiTankMinePerLorry = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'Type of Anti Personnel Mine',
                  hintText: 'Type of Anti Personnel Mine',
                  value: _model.noOfantiPersonnelMinePerLorry,
                  filled: false,
                  dataSource: [
                    {
                      "display": "Anti Personnel Mine Shrapnel Mark II",
                      "value": 528,
                    },
                    {
                      "display": "Anti Personnel Tank Mine No 6",
                      "value": 4500,
                    },
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _model.noOfantiPersonnelMinePerLorry = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'Type of Outer Strip',
                  hintText: 'Type of Outer Strip',
                  value: _model.typeOfOuterStrip,
                  filled: false,
                  dataSource: [
                    {
                      "display": "Mixed Trip with Trip Wire",
                      "value": OuterStrip.TripWireCluster,
                    },
                    {
                      "display": "Mixed Trip without Trip Wire",
                      "value": OuterStrip.MixedCluster,
                    },
                    {
                      "display": "Anti Tank Cluster",
                      "value": OuterStrip.AntiTankCluster,
                    },
                  ],
                  onChanged: (OuterStrip value) {
                    setState(() {
                      _model.typeOfOuterStrip = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'D-Day',
                  hintText: 'Select D-Day',
                  value: _model.dDay,
                  filled: false,
                  dataSource: MoonLit.listOfMoonlit
                      .map((MoonLit option) =>
                          {"display": option.title, "value": option.value})
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      _model.dDay = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
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
                InputSubmitButton(handleSubmit)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
