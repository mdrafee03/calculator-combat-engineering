import 'dart:math';

class SpanRoadway {
  double length;
  double thicknessOfRoadway;
  double thicknessOfBeam;
  double height;
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
    return totalChargeBeams * noOfSpans;
  }

  int get sanbagPerSpan {
    return (20 / 25 * totalChargeBeams).ceil();
  }

  int get totalSandbagForSpan {
    return (sanbagPerSpan * noOfSpans).ceil();
  }
}
