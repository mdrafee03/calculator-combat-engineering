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

  double get plasticExplosive {
    double abutment = listOfAbutment.fold(
        0,
        (previousValue, element) =>
            previousValue + element.totalChargeRequired(element.craterNo));
    double borehole = pier.boreholePier.totalChargeRequired;
    double pierFooting = pier.footingPier.totalAmountOfCharge;
    double roadway = listOfRoadway.fold(
        0,
        (previousValue, element) =>
            previousValue + element.totalChargeRequired);
    double span = spanBeamGirder.totalChargeRequired;

    return abutment + borehole + roadway + span + pierFooting;
  }
}
