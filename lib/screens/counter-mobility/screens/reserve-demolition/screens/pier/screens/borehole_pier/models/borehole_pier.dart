import './borehole_depth_pier.dart';
import './borehole_pier_type.dart';

class BoreholePier {
  double width;
  double thickness;
  BoreholePierType typeOfBoreholePier;
  int row;
  bool isBoth;
  int noOfPier;

  int get noOfHolesPerRow {
    return (width / 3).round();
  }

  int get totalNoOfholes {
    if (isBoth) {
      return noOfHolesPerRow * (row * 2) - row;
    } else {
      return noOfHolesPerRow * row - (row ~/ 2);
    }
  }

  int get depthOfHole {
    return ((2 * thickness / 3) * 12).ceil();
  }

  int get depthOfExplosiveToBeFilled {
    return (depthOfHole / 2).ceil();
  }

  double get diaOfBorehole {
    return typesOfBoreHoleDepthPier
        .firstWhere((element) =>
            depthOfHole > element.range[0] && depthOfHole <= element.range[1])
        .dia;
  }

  double get chargeRequiredOneHole {
    double charge = 0;
    if (depthOfHole > 40) {
      charge += (40 - depthOfHole.toDouble() / 2) * 2.5;
      if (depthOfHole > 60) {
        charge += 20 * 2;
        charge += (depthOfHole - 60) * 1.5;
      } else {
        charge += (depthOfHole - 40) * 2;
      }
    } else {
      charge = depthOfHole / 2 * 2.5;
    }
    return charge;
  }

  double get totalChargeRequiredOnePier {
    return totalNoOfholes * chargeRequiredOneHole / 16;
  }

  double get totalAmountForAllPiers {
    return noOfPier * totalChargeRequiredOnePier;
  }
}
