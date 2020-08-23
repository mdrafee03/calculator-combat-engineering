import 'package:flutter/material.dart';

import '../screens/counter-mobility/counter_mobility.dart';
import '../screens/mobility/mobility.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_input.dart';
import '../screens/home.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_output.dart';
import './route_const.dart';

class Router {
  static Map<String, WidgetBuilder> mainRouter() {
    return <String, WidgetBuilder>{
      home: (BuildContext ctx) => Home(),
      mobility: (BuildContext ctx) => Mobility(),
      counterMobility: (BuildContext ctx) => CounterMobility(),
      minefieldLayingInput: (BuildContext ctx) => MineFieldLayingInput(),
      minefieldLayingOutput: (BuildContext ctx) => MinefieldLayingOutput(),
    };
  }
}
