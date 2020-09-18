import '../../../../../shared/extension-methods/double_apis.dart';
import '../models/laid_anchor_hpb.dart';
import './remainder_hpb.dart';

class HeavyPontoonBridge {
  int classification;
  int numberOfLanes;
  double currentVelocity;
  double distanceNearShore;
  double distanceFarShore;
  double riverWidth;

  Map<String, dynamic> get numberOfInterior {
    double interior = riverWidth - (distanceNearShore + distanceFarShore);
    return {"dividend": (interior ~/ 2.7), "remainder": (interior % 2.7)};
  }

  int get numberOfTransporter {
    return (numberOfInterior["dividend"] / 2).floor();
  }

  int get numberOfPontoonBays {
    return (numberOfInterior["dividend"] / 4).floor();
  }

  double get lengthOfRiverPart {
    return numberOfInterior["dividend"] * 2.7;
  }

  Map<String, dynamic> get numberOfPierNearshore {
    double pier = (distanceNearShore - 2);
    return {"dividend": (pier ~/ 5), "remainder": (pier % 5)};
  }

  Map<String, dynamic> get numberOfPierFarshore {
    double pier = (distanceFarShore - 2);
    return {"dividend": (pier ~/ 5), "remainder": (pier % 5)};
  }

  double get totalRemainder {
    double remainders = (numberOfInterior["remainder"] +
        numberOfPierNearshore["remainder"] +
        numberOfPierFarshore["remainder"]);
    return remainders.toDoubleAsPrecision();
  }

  bool get isSolution1Preferred {
    return totalRemainder <= 2.0;
  }

  double get solution1 {
    return RemainderHPB.listOfRemainder
        .firstWhere((element) => totalRemainder / 2 <= element.remainder)
        .towardsCurrent;
  }

  RemainderHPB get solution2 {
    return RemainderHPB.listOfRemainder
        .firstWhere((element) => totalRemainder <= element.remainder);
  }

  double get bigRampBank {
    if (isSolution1Preferred) {
      return 3.7 - (2 + solution1);
    } else {
      return (3.7 - (2 + solution2.towardsCurrent - solution2.towardsBank));
    }
  }

  double get bigRampWater {
    return 3.7 - bigRampBank;
  }

  int get numberOfInteriorCorrected {
    return numberOfInterior["dividend"] - solution2.reduceInterior;
  }

  int get numberOfTranporterCorrected {
    return (numberOfInteriorCorrected / 2).floor();
  }

  int get numberOfPontoonCorrected {
    return (numberOfInteriorCorrected / 4).floor();
  }

  double get lengthOfRiverPartCorrected {
    return numberOfInteriorCorrected * 2.7;
  }

  int get numberOfPierNearShoreCorrected {
    return numberOfPierNearshore["dividend"] + solution2.increaseSpan;
  }

  int get numberOfPierNearshorePreferred => isSolution1Preferred
      ? numberOfPierNearshore["dividend"]
      : numberOfPierNearShoreCorrected;

  double get lengthOfPierNearshore {
    return 5 * numberOfPierNearshorePreferred + 3.7;
  }

  double get lengthOfPierFarshore {
    return 5 * numberOfPierFarshore["dividend"] + 3.7;
  }

  double get distanceTrestleAndWater {
    return lengthOfPierNearshore - bigRampBank;
  }

  int get numberOfRampbaysNearshore {
    int factor = numberOfLanes == 1 ? 2 : 4;
    return numberOfPierNearshorePreferred * factor;
  }

  int get numberOfRampbaysFarshore {
    int factor = numberOfLanes == 1 ? 2 : 4;
    return numberOfPierFarshore["dividend"] * factor;
  }

  int get totalRampbays {
    return numberOfRampbaysNearshore + numberOfRampbaysFarshore;
  }

  double get lengthOfFloatingBridge {
    double river =
        isSolution1Preferred ? lengthOfRiverPart : lengthOfRiverPartCorrected;
    return river + lengthOfPierNearshore + lengthOfPierFarshore;
  }

  List<int> get laidAnchor {
    int interior = isSolution1Preferred
        ? numberOfInterior["dividend"]
        : numberOfInteriorCorrected;
    LaidAnchorHPB anchor = LaidAnchorHPB.listOfLaidAnchor.firstWhere(
        (element) =>
            currentVelocity <= element.current &&
            element.type == classification);
    return [
      (interior * anchor.upstream).ceil(),
      (interior * anchor.downstream).ceil()
    ];
  }
}
