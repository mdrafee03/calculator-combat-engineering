import '../screens/abutment/models/abutment.dart';
import '../screens/pier/models/pier.dart';
import '../screens/span-beam-girder/models/span_beam_girder.dart';

class ReserveDemolition {
  List<Abutment> listOfAbutment = [];
  Pier pier = Pier();
  SpanBeamGirder spanBeamGirder;

  static ReserveDemolition currentReserveDemolition;

  double get plasticExplosive {
    double abutment = listOfAbutment?.fold(
            0,
            (previousValue, element) =>
                previousValue +
                    element.totalChargeRequired(element.craterNo ?? 0) ??
                0) ??
        0;
    double borehole = pier?.boreholePier?.width != null
        ? pier?.boreholePier?.totalChargeRequired ?? 0
        : 0;
    double pierFooting = pier?.footingPier?.width != null
        ? pier?.footingPier?.totalAmountOfCharge ?? 0
        : 0;
    double span = spanBeamGirder?.length != null
        ? spanBeamGirder?.totalChargeRequired ?? 0
        : 0;

    return abutment + borehole + span + pierFooting;
  }

  double get totalTimeRequired {
    double abutmentTime = listOfAbutment.fold(0,
        (previousValue, element) => previousValue + element.totalTimeRequired);
    double pierTime = pier?.boreholePier?.totalChargeRequired ?? 0;
    double spanTime = spanBeamGirder?.totalTimeRequired ?? 0;
    return abutmentTime + pierTime + spanTime;
  }

  int get hayrics {
    return pier?.shapedPier?.dia != null
        ? pier?.shapedPier?.totalNoOfHyrics ?? 0
        : 0;
  }
}
