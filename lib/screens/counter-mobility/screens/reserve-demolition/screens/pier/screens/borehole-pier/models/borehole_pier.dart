import './borehole_pier_type.dart';

class BoreholePier {
  double width;
  double thickness;
  BoreholePierType typeOfBoreholePier;
  int row;
  int noOfPier;

  int get noOfHolesPerRow {
    return (width / 3).round();
  }

  int get totalNoOfholes {
    if (typeOfBoreholePier.id == "4") {
      return noOfHolesPerRow * (row * 2) - row;
    } else {
      return noOfHolesPerRow * row - (row ~/ 2);
    }
  }

  int get depthOfHole {
    if (typeOfBoreholePier.id == "4") {
      return (thickness / 2 * 12).ceil();
    } else {
      return ((2 * thickness / 3) * 12).ceil();
    }
  }

  int get depthOfExplosiveToBeFilled {
    return (depthOfHole / 2).ceil();
  }

  Map get chargeRequiredOneHole {
    List<Map<String, dynamic>> dias = [];
    double time = 0;
    double charge = 0;
    if (depthOfHole > 40) {
      charge += (40 - depthOfHole.toDouble() / 2) * 2.5;
      time += charge * 5 / 12;
      dias.add({"dia": 2, "depth": (40 - depthOfHole / 2)});
      if (depthOfHole > 60) {
        charge += 20 * 2;
        time += (20 * 2) * 6 / 12;
        dias.add({"dia": 1.75, "depth": 20});
        charge += (depthOfHole - 60) * 1.5;
        time += ((depthOfHole - 60) * 1.5) * 7 / 12;
        dias.add({"dia": 1.5, "depth": (depthOfHole - 60)});
      } else {
        charge += (depthOfHole - 40) * 2;
        time += ((depthOfHole - 40) * 2) * 6 / 12;
        dias.add({"dia": 1.75, "depth": (depthOfHole - 40)});
      }
    } else {
      charge += depthOfHole / 2 * 2.5;
      time += charge * 5 / 12;
      dias.add({"dia": 2, "depth": depthOfHole / 2});
    }
    return {"dias": dias, "charge": charge, "time": time.ceil()};
  }

  double get totalChargeRequiredOnePier {
    return totalNoOfholes * chargeRequiredOneHole["charge"] / 16;
  }

  double get totalAmountForAllPiers {
    return noOfPier * totalChargeRequiredOnePier;
  }
}
