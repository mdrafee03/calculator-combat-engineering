import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/counter-mobility/screens/counter_mobility_screen.dart';
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
import '../screens/counter-mobility/screens/combined-project/screens/combined_project_input.dart';
import '../screens/counter-mobility/screens/combined-project/screens/combined_project_output.dart';
import '../screens/mobility/screens/mobility_screen.dart';
import '../screens/mobility/screens/baily-bridge/screens/baily_bridge_list.dart';
import '../screens/mobility/screens/baily-bridge/screens/baily_bridge_input.dart';
import '../screens/mobility/screens/baily-bridge/screens/baily_bridge_output.dart';
import '../screens/mobility/screens/heavy-pontoon-bridge/screens/heavy_pontoon_bridge_input.dart';
import '../screens/mobility/screens/heavy-pontoon-bridge/screens/heavy_pontoon_bridge_list.dart';
import '../screens/mobility/screens/heavy-pontoon-bridge/screens/heavy_pontoon_bridge_output.dart';
import '../screens/mobility/screens/minefield-breaching/screens/minefield_breaching_input.dart';
import '../screens/mobility/screens/minefield-breaching/screens/minefield_breaching_list.dart';
import '../screens/mobility/screens/minefield-breaching/screens/minefield_breaching_output.dart';

import './route_const.dart';

class Router {
  static Map<String, WidgetBuilder> mainRouter() {
    return <String, WidgetBuilder>{
      home: (BuildContext ctx) => Home(),
      // counter mobility
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
      combinedProjectInput: (BuildContext ctx) => CombinedProjectInput(),
      combinedProjectOutput: (BuildContext ctx) => CombinedProjectOutput(),
      // mobility
      mobilityScreen: (BuildContext ctx) => MobilityScreen(),
      bailyBridgeList: (BuildContext ctx) => BailyBridgeList(),
      bailyBridgeInput: (BuildContext ctx) => BailyBridgeInput(),
      bailyBridgeOutput: (BuildContext ctx) => BailyBridgeOutput(),
      heavyPontoonBridgeList: (BuildContext ctx) => HeavyPontoonBridgeList(),
      heavyPontoonBridgeInput: (BuildContext ctx) => HeavyPontoonBridgeInput(),
      heavyPontoonBridgeOutput: (BuildContext ctx) =>
          HeavyPontoonBridgeOutput(),
      minefieldBreachingList: (BuildContext ctx) => MinefieldBreachingList(),
      minefieldBreachingInput: (BuildContext ctx) => MinefieldBreachingInput(),
      minefieldBreachingOutput: (BuildContext ctx) =>
          MinefieldBreachingOutput(),
    };
  }
}
