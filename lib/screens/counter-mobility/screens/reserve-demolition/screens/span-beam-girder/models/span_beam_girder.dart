import 'dart:math';

import '../../summary/models/reserve_demolition_summary.dart';
import './time_manpower.dart';

class SpanBeamGirder {
  double length;
  double thicknessOfRoadway;
  double thicknessOfBeam;
  double height;
  double width;
  int noOfBeams;
  int noOfSpans;

  double get chargeOfEachBeam {
    return (4 *
        pow(((height + thicknessOfRoadway) / 12), 2) *
        (thicknessOfBeam / 12));
  }

  double get totalChargeBeams {
    return chargeOfEachBeam * noOfBeams;
  }

  double get totalChargeSpans {
    double charge = totalChargeBeams * noOfSpans;
    ReserveDemolitionSummary.spanCharge = charge;
    return charge;
  }

  int get sanbagPerSpan {
    return (20 / 25 * totalChargeBeams).ceil();
  }

  int get totalSandbagForSpan {
    int sandbag = (sanbagPerSpan * noOfSpans);
    ReserveDemolitionSummary.sandbag = sandbag;
    return sandbag;
  }

  int get timeRequiredPerSection {
    TimeManpower timeManpower = listOfTimeAndManpower.firstWhere(
      (element) =>
          width > element.width[0] &&
          width <= element.width[1] &&
          length > element.length[0] &&
          length <= element.length[1],
    );
    return noOfSpans * timeManpower.time * timeManpower.manpower;
  }

  double get totalTimeRequired {
    double time =
        (timeRequiredPerSection / 4) >= 1 ? (timeRequiredPerSection / 4) : 1;
    ReserveDemolitionSummary.spanTime = time;
    return time;
  }
}