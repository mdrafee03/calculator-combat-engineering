import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/counter-mobility/screens/counter_mobility_screen.dart';
import '../screens/mobility/mobility.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_list.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_input.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/reserve_demolition_list.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/reserve_demolition_children.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/abutment/screens/abutment_list.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/abutment/screens/abutment_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/abutment/screens/abutment_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/pier_screen.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/borehole-pier/screens/borehole_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/borehole-pier/screens/borehole_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/shaped-pier/screens/shaped_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/shaped-pier/screens/shaped_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/footing-pier/screens/footing_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/footing-pier/screens/footing_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/span-beam-girder/screens/span_beam_girder_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/span-beam-girder/screens/span_beam_girder_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/roadway/screens/roadway_list.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/roadway/screens/roadway_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/roadway/screens/roadway_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/summary/screens/reserve_demolition_summary_screen.dart';
import '../screens/counter-mobility/screens/wire-obstacle/screens/wire_obstacle_list.dart';
import '../screens/counter-mobility/screens/wire-obstacle/screens/wire_obstacle_input.dart';
import '../screens/counter-mobility/screens/wire-obstacle/screens/wire_obstacle_output.dart';
import '../screens/counter-mobility/screens/anit-tank/screens/anti_tank_list.dart';
import '../screens/counter-mobility/screens/anit-tank/screens/anti_tank_input.dart';
import '../screens/counter-mobility/screens/anit-tank/screens/anti_tank_output.dart';

import './route_const.dart';

class Router {
  static Map<String, WidgetBuilder> mainRouter() {
    return <String, WidgetBuilder>{
      home: (BuildContext ctx) => Home(),
      mobility: (BuildContext ctx) => Mobility(),
      counterMobilityScreen: (BuildContext ctx) => CounterMobilityScreen(),
      minefieldLayingList: (BuildContext ctx) => MinefieldLayingList(),
      minefieldLayingInput: (BuildContext ctx) => MineFieldLayingInput(),
      minefieldLayingOutput: (BuildContext ctx) => MinefieldLayingOutput(),
      reserveDemolitionList: (BuildContext ctx) => ReserveDemolitionList(),
      reserveDemolitionChildren: (BuildContext ctx) =>
          ReserveDemolitionChildren(),
      abutmentList: (BuildContext ctx) => AbutmentList(),
      abutmentInput: (BuildContext ctx) => AbutmentInput(),
      abutmentOutput: (BuildContext ctx) => AbutmentOutput(),
      pierScreen: (BuildContext ctx) => PierScreen(),
      boreholePierInput: (BuildContext ctx) => BoreholePierInput(),
      boreholePierOutput: (BuildContext ctx) => BoreholePierOutput(),
      shapedPierInput: (BuildContext ctx) => ShapedPierInput(),
      shapedPierOutput: (BuildContext ctx) => ShapedPierOutput(),
      footingPierInput: (BuildContext ctx) => FootingPierInput(),
      footingPierOutput: (BuildContext ctx) => FootingPierOutput(),
      spanBeamGirderInput: (BuildContext ctx) => SpanBeamGirderInput(),
      spanBeamGirderOutput: (BuildContext ctx) => SpanBeamGirderOutput(),
      roadwayList: (BuildContext ctx) => RoadwayList(),
      roadwayInput: (BuildContext ctx) => RoadwayInput(),
      roadwayOutput: (BuildContext ctx) => RoadwayOutput(),
      reserveDemolitionSummary: (BuildContext ctx) =>
          ReserveDemolitionSummaryScreen(),
      wireObstacleList: (BuildContext ctx) => WireObstacleList(),
      wireObstacleInput: (BuildContext ctx) => WireObstacleInput(),
      wireObstacleOuput: (BuildContext ctx) => WireObstacleOutput(),
      antiTankList: (BuildContext ctx) => AntiTankList(),
      antiTankInput: (BuildContext ctx) => AntiTankInput(),
      antiTankOuput: (BuildContext ctx) => AntiTankOutput(),
    };
  }
}
