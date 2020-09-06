import './borehole_pier_type.dart';
import './borehole_pier_calc.dart';

class BoreholePier {
  double width;
  double thickness;
  BoreholePierType typeOfBoreholePier;
  int row;
  int noOfPier;

  int totalTime;
  double totalCharge;

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

  List<BoreholePierCalc> get chargeAndTimeCalucation {
    List<BoreholePierCalc> chargesNTimes = [];
    if (depthOfHole > 40) {
      chargesNTimes.add(
        new BoreholePierCalc(
          dia: 2,
          depth: 40 - depthOfHole / 2,
          timeDepth: 40,
          time: 7 * 40 / 12,
          charge: (40 - depthOfHole.toDouble() / 2) * 2.5,
        ),
      );
      if (depthOfHole > 60) {
        chargesNTimes.add(
          new BoreholePierCalc(
            dia: 1.75,
            depth: 20,
            timeDepth: 20,
            time: 6 * 20 / 12,
            charge: 20.0 * 2,
          ),
        );
        chargesNTimes.add(
          new BoreholePierCalc(
            dia: 1.5,
            depth: (depthOfHole - 60).toDouble(),
            timeDepth: (depthOfHole - 60).toDouble(),
            time: (5 * (depthOfHole - 60) / 12),
            charge: (depthOfHole - 60) * 1.5,
          ),
        );
      } else {
        chargesNTimes.add(
          new BoreholePierCalc(
            dia: 1.75,
            depth: (depthOfHole.toDouble() - 40),
            timeDepth: (depthOfHole.toDouble() - 40),
            time: (6 * (depthOfHole.toDouble() - 40) / 12),
            charge: (depthOfHole.toDouble() - 40) * 2,
          ),
        );
      }
    } else {
      chargesNTimes.add(
        new BoreholePierCalc(
          dia: 2,
          depth: depthOfHole / 2,
          timeDepth: depthOfHole.toDouble(),
          time: 7 * depthOfHole.toDouble() / 12,
          charge: (depthOfHole.toDouble() / 2) * 2.5,
        ),
      );
    }
    totalTime =
        chargesNTimes.fold(0, (value, element) => value + element.time).ceil();
    totalCharge =
        chargesNTimes.fold(0, (value, element) => value + element.charge);
    return chargesNTimes;
  }

  double get totalChargeRequiredOnePier {
    return totalNoOfholes * totalCharge / 16;
  }

  double get totalTimeRequired {
    double time = (totalTime * totalNoOfholes / 2) / 60;
    return time;
  }

  double get totalChargeRequired {
    double charge = noOfPier * totalChargeRequiredOnePier;
    return charge;
  }
}
