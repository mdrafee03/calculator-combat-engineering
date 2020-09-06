import '../../../models/reserve_demolition.dart';

class ReserveDemolitionSummary {
  double abutmentCharge = 0;
  double pierCharge = 0;
  double spanCharge = 0;
  double roadwayCharge = 0;

  double abutmentTime = 0;
  double pierTime = 0;
  double spanTime = 0;
  double roadwayTime = 0;
  int sandbag = 0;
  ReserveDemolitionSummary() {
    ReserveDemolition _current = ReserveDemolition.currentReserveDemolition;
    _current.listOfAbutment.forEach((element) {
      abutmentCharge += element?.totalChargeRequired(element.craterNo) ?? 0;
      abutmentTime += element?.totalTimeRequired ?? 0;
    });
    pierCharge = _current?.pier?.boreholePier?.totalChargeRequired ?? 0;
    pierTime = _current?.pier?.boreholePier?.totalTimeRequired ?? 0;

    spanCharge = _current?.spanBeamGirder?.totalChargeRequired ?? 0;
    spanTime = _current?.spanBeamGirder?.totalTimeRequired ?? 0;
    sandbag = _current?.spanBeamGirder?.totalSandbagRequired ?? 0;

    _current.listOfRoadway.forEach((element) {
      roadwayCharge += element.totalChargeRequired ?? 0;
      roadwayTime += element.totalTimeRequired ?? 0;
    });
  }

  double get totalExplosiveRequired {
    return abutmentCharge + pierCharge + spanCharge + roadwayCharge;
  }

  double get totalTimeRequired {
    return abutmentTime + pierTime + spanTime + roadwayTime;
  }

  int get getSandbag {
    return sandbag;
  }
}
