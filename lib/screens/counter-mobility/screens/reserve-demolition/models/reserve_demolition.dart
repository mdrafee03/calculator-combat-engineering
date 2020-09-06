import '../screens/abutment/models/abutment.dart';
import '../screens/pier/models/pier.dart';
import '../screens/roadway/models/roadway.dart';
import '../screens/span-beam-girder/models/span_beam_girder.dart';

class ReserveDemolition {
  List<Abutment> listOfAbutment = [];
  Pier pier = Pier();
  List<Roadway> listOfRoadway = [];
  SpanBeamGirder spanBeamGirder;

  static ReserveDemolition currentReserveDemolition;
}
