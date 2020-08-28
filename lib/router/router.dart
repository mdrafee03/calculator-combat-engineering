import 'package:flutter/material.dart';

import '../screens/counter-mobility/counter_mobility.dart';
import '../screens/mobility/mobility.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_input.dart';
import '../screens/home.dart';
import '../screens/counter-mobility/screens/minefield-laying/screens/minefield_laying_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/reserve_demolition.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/abutment/screens/abutment_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/abutment/screens/abutment_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/pier.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/borehole-pier/screens/borehole_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/borehole-pier/screens/borehole_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/shaped-pier/screens/shaped_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/shaped-pier/screens/shaped_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/footing-pier/screens/footing_pier_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/pier/screens/footing-pier/screens/footing_pier_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/span-beam-girder/screens/span_beam_girder_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/span-beam-girder/screens/span_beam_girder_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/roadway/screens/roadway_input.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/roadway/screens/roadway_output.dart';
import '../screens/counter-mobility/screens/reserve-demolition/screens/summary/screens/reserve_demolition_summary_screen.dart';
import './route_const.dart';

class Router {
  static Map<String, WidgetBuilder> mainRouter() {
    return <String, WidgetBuilder>{
      home: (BuildContext ctx) => Home(),
      mobility: (BuildContext ctx) => Mobility(),
      counterMobility: (BuildContext ctx) => CounterMobility(),
      minefieldLayingInput: (BuildContext ctx) => MineFieldLayingInput(),
      minefieldLayingOutput: (BuildContext ctx) => MinefieldLayingOutput(),
      reserveDemolition: (BuildContext ctx) => ReserveDemolition(),
      abutmentInput: (BuildContext ctx) => AbutmentInput(),
      abutmentOutput: (BuildContext ctx) => AbutmentOutput(),
      pier: (BuildContext ctx) => Pier(),
      boreholePierInput: (BuildContext ctx) => BoreholePierInput(),
      boreholePierOutput: (BuildContext ctx) => BoreholePierOutput(),
      shapedPierInput: (BuildContext ctx) => ShapedPierInput(),
      shapedPierOutput: (BuildContext ctx) => ShapedPierOutput(),
      footingPierInput: (BuildContext ctx) => FootingPierInput(),
      footingPierOutput: (BuildContext ctx) => FootingPierOutput(),
      spanBeamGirderInput: (BuildContext ctx) => SpanBeamGirderInput(),
      spanBeamGirderOutput: (BuildContext ctx) => SpanBeamGirderOutput(),
      roadwayInput: (BuildContext ctx) => RoadwayInput(),
      roadwayOutput: (BuildContext ctx) => RoadwayOutput(),
      reserveDemolitionSummary: (BuildContext ctx) =>
          ReserveDemolitionSummaryScreen(),
    };
  }
}
