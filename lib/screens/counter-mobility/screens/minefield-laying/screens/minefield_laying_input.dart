import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../../../models/counter_mobility.dart';
import '../models/moon_lit.dart';
import '../../../../../router/route_const.dart';
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
    MinefieldLaying _minefieldLaying =
        ModalRoute.of(context).settings.arguments;
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      var isExist =
          CounterMobility.listOfMinefieldLaying.indexOf(_minefieldLaying);
      if (isExist == -1) {
        CounterMobility.listOfMinefieldLaying.add(_minefieldLaying);
      }
      Navigator.pushNamed(context, minefieldLayingOutput,
          arguments: _minefieldLaying);
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
                  initialValue: _minefieldLaying.frontage != null
                      ? _minefieldLaying.frontage.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _minefieldLaying.frontage = double.parse(val)),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Depth", labelText: "Depth"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.depth != null
                      ? _minefieldLaying.depth.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _minefieldLaying.depth = double.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Density", labelText: "Density"),
                  initialValue: _minefieldLaying.density != null
                      ? _minefieldLaying.density.toString()
                      : null,
                  onSaved: (val) => setState(
                    () => _minefieldLaying.density =
                        _minefieldLaying.convertToFraction(val),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of mixed strip",
                      labelText: "Number of mixed strip"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.numberOfMixedStrip != null
                      ? _minefieldLaying.numberOfMixedStrip.toString()
                      : null,
                  onSaved: (val) => setState(() =>
                      _minefieldLaying.numberOfMixedStrip = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of IOE group",
                      labelText: "Number of IOE group"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.numberOfIOEGroup != null
                      ? _minefieldLaying.numberOfIOEGroup.toString()
                      : null,
                  onSaved: (val) => setState(
                      () => _minefieldLaying.numberOfIOEGroup = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Cluster per group",
                      labelText: "Number of Cluster per group"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.numberOfClusterPerGroup != null
                      ? _minefieldLaying.numberOfClusterPerGroup.toString()
                      : null,
                  onSaved: (val) => setState(() => _minefieldLaying
                      .numberOfClusterPerGroup = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Total turning points",
                      labelText: "Total turning points (TP) (per strip)"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.totalTurningPointsPerStrip !=
                          null
                      ? _minefieldLaying.totalTurningPointsPerStrip.toString()
                      : null,
                  onSaved: (val) => setState(() => _minefieldLaying
                      .totalTurningPointsPerStrip = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Field Engineer platoon",
                      labelText: "Number of Field Engineer platoon"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _minefieldLaying.noOfFieldEngineerPlatoon != null
                          ? _minefieldLaying.noOfFieldEngineerPlatoon.toString()
                          : null,
                  onSaved: (val) => setState(() => _minefieldLaying
                      .noOfFieldEngineerPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Number of Infantry platoon",
                      labelText: "Number of Infantry platoon"),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.noOfInfantryPlatoon != null
                      ? _minefieldLaying.noOfInfantryPlatoon.toString()
                      : null,
                  onSaved: (val) => setState(() =>
                      _minefieldLaying.noOfInfantryPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText:
                          "No of Engineer Platoon Assisted By Infantry platoon",
                      labelText:
                          "No of Engineer Platoon Assisted By Infantry platoon"),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _minefieldLaying.noOfAssistedByInfantryPlatoon != null
                          ? _minefieldLaying.noOfAssistedByInfantryPlatoon
                              .toString()
                          : null,
                  onSaved: (val) => setState(() => _minefieldLaying
                      .noOfAssistedByInfantryPlatoon = int.parse(val)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Trip Wire of Mixed Cluster",
                    labelText: "Trip Wire of Mixed Cluster (%)",
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _minefieldLaying.percentageOfTripWire != null
                      ? _minefieldLaying.percentageOfTripWire.toString()
                      : null,
                  onSaved: (val) => setState(() => _minefieldLaying
                      .percentageOfTripWire = double.parse(val)),
                ),
                DropDownFormField(
                  titleText: 'Type of Anti Tank Mine',
                  hintText: 'Type of Anti Tank Mine',
                  value: _minefieldLaying.noOfantiTankMinePerLorry,
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
                      _minefieldLaying.noOfantiTankMinePerLorry = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'Type of Anti Personnel Mine',
                  hintText: 'Type of Anti Personnel Mine',
                  value: _minefieldLaying.noOfantiPersonnelMinePerLorry,
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
                      _minefieldLaying.noOfantiPersonnelMinePerLorry = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'Type of Outer Strip',
                  hintText: 'Type of Outer Strip',
                  value: _minefieldLaying.typeOfOuterStrip,
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
                      _minefieldLaying.typeOfOuterStrip = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                DropDownFormField(
                  titleText: 'D-Day',
                  hintText: 'Select D-Day',
                  value: _minefieldLaying.dDay,
                  filled: false,
                  dataSource: listOfMoonlit
                      .map((MoonLit option) =>
                          {"display": option.title, "value": option.value})
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      _minefieldLaying.dDay = value;
                    });
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
                ListTile(
                  title: Text(
                    "First Light: ${_minefieldLaying.firstLight.format(context)}",
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    TimeOfDay t = await showTimePicker(
                      context: context,
                      initialTime: _minefieldLaying.firstLight,
                    );
                    if (t != null) {
                      setState(() {
                        _minefieldLaying.firstLight = t;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "Last Light: ${_minefieldLaying.lastLight.format(context)}",
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: () async {
                    TimeOfDay t = await showTimePicker(
                      context: context,
                      initialTime: _minefieldLaying.lastLight,
                    );
                    if (t != null) {
                      setState(() {
                        _minefieldLaying.lastLight = t;
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
