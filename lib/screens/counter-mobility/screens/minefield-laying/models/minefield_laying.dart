import 'dart:math';

import 'package:fraction/fraction.dart';

import '../../../../../shared//extension-methods/double_apis.dart';

enum OuterStrip {
  TripWireCluster,
  MixedCluster,
  AntiTankCluster,
}

class MinefieldLaying {
  final Fraction standardDensity = Fraction.fromDouble(1 / 3);
  final double lengthOfGuideTape = 200;
  final double barbedWirePerLorry = 24;
  final double longPicketsPerLorry = 100;
  final double shortPicketsPerLorry = 50;
  final double perimeterSignsPerLorry = 75;
  final double noOfPersonsPerLorry = 28;
  final double noOfFieldEngineersPerPlatoon = 51;
  final double noOfInfantryPerPlatoon = 35;

  double frontage;
  double depth;
  Fraction density;
  double numberOfMixedStrip;
  double numberOfIOEGroup;
  double numberOfClusterPerGroup;
  double totalTurningPointsPerStrip;
  double noOfFieldEngineerPlatoon;
  double noOfInfantryPlatoon = 0;
  double noOfAssistedByInfantryPlatoon = 0;
  double percentageOfTripWiredOfMixedClustersOfOuterRowOfMixedStrip;
  double antiTankMinePerLorry;
  double antiPersonnelMinePerLorry;
  OuterStrip typeOfOuterStrip;
  int dDay;

  int get numberOfStrips {
    return (density / standardDensity).toDouble().toDoubleAsPrecision().ceil();
  }

  int get numberOfClusterPerStrip {
    return (Fraction.fromDouble(frontage) * standardDensity)
        .toDouble()
        .toDoubleAsPrecision()
        .ceil();
  }

  int get antiTankMines {
    return ((numberOfStrips * numberOfClusterPerStrip +
                numberOfIOEGroup * numberOfClusterPerGroup) *
            1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get antiPersonnelMines {
    return ((3 * numberOfMixedStrip * numberOfClusterPerStrip +
                3 * numberOfIOEGroup * numberOfClusterPerGroup) *
            1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get longPicket {
    return ((((frontage + 2 * depth) / 20) + 1) * 1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get shortPicket {
    return (((frontage / 20 +
                    2 * totalTurningPointsPerStrip * numberOfStrips +
                    2 * numberOfStrips) +
                (numberOfStrips * frontage / 100) +
                (2 * numberOfIOEGroup)) *
            1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get barbedWire {
    return ((3 * frontage + 4 * depth) / 100).ceil();
  }

  int get perimeterSignPosting {
    return (((2 * frontage + 2 * depth) / 40) * 1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get tracingTape {
    return (((numberOfStrips * frontage + 2 * depth + lengthOfGuideTape) / 50) *
            1.1)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get totalLorryForAntiTankMine {
    return (antiTankMines / antiTankMinePerLorry).toDoubleAsPrecision().ceil();
  }

  int get totalLorryForAntiPersonnelMine {
    return (antiPersonnelMines / antiPersonnelMinePerLorry)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get totalLorryForStores {
    int totalLorryForBarbedWire =
        (barbedWire / barbedWirePerLorry).toDoubleAsPrecision().ceil();
    int totalLorryForLongPickets =
        (longPicket / longPicketsPerLorry).toDoubleAsPrecision().ceil();
    int totalLorryForShortPickets =
        (shortPicket / shortPicketsPerLorry).toDoubleAsPrecision().ceil();
    int totalLorryForPerimeterSigns =
        (perimeterSignPosting / perimeterSignsPerLorry)
            .toDoubleAsPrecision()
            .ceil();
    return [
      totalLorryForBarbedWire,
      totalLorryForLongPickets,
      totalLorryForShortPickets,
      totalLorryForPerimeterSigns
    ].reduce(max);
  }

  int get totalLorryForPersonnel {
    double totalManPower =
        (noOfFieldEngineersPerPlatoon * noOfFieldEngineerPlatoon +
            noOfInfantryPerPlatoon *
                (noOfInfantryPlatoon + noOfAssistedByInfantryPlatoon));
    return (totalManPower / noOfPersonsPerLorry).toDoubleAsPrecision().ceil();
  }

  double get platoonWeight {
    return (noOfFieldEngineerPlatoon +
        0.5 * noOfInfantryPlatoon +
        1.5 * noOfAssistedByInfantryPlatoon);
  }

  int get antiTankClusterPerHourMoonlit {
    return (platoonWeight * 200 * 2 / 3).toDoubleAsPrecision().ceil();
  }

  int get antiTankClusterPerHourDarklit {
    return (platoonWeight * 200 * 1 / 2).toDoubleAsPrecision().ceil();
  }

  int get mixedClusterPerHourMoonlit {
    return (platoonWeight * 100 * 2 / 3).toDoubleAsPrecision().ceil();
  }

  int get mixedClusterPerHourDarklit {
    return (platoonWeight * 100 * 1 / 2).toDoubleAsPrecision().ceil();
  }

  int get trippedWirePerHourMoonlit {
    return (platoonWeight * 75 * 2 / 3).toDoubleAsPrecision().ceil();
  }

  int get trippedWirePerHourDarklit {
    return (platoonWeight * 75 * 1 / 2).toDoubleAsPrecision().ceil();
  }

  Fraction convertToFraction(String val) {
    return double.tryParse(val) != null
        ? Fraction.fromDouble(double.parse(val))
        : Fraction.fromString(val);
  }
}
