import 'dart:math';

import 'package:combat_engineering/screens/counter-mobility/screens/minefield-laying/models/minefield_time.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import '../../../../../shared//extension-methods/double_apis.dart';
import '../../../../../shared//extension-methods/timeOfDay_apis.dart';

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
  double percentageOfTripWire;
  double antiTankMinePerLorry;
  double antiPersonnelMinePerLorry;
  OuterStrip typeOfOuterStrip;
  int dDay;
  TimeOfDay firstLight = TimeOfDay.now();
  TimeOfDay lastLight = TimeOfDay.now();

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

  MinefieldTime get timeRequired {
    final double antiTankClusterPerHourMoonlit =
        (platoonWeight * 200 * 2 / 3).toDoubleAsPrecision().ceil().toDouble();
    final double antiTankClusterPerHourDark =
        (platoonWeight * 200 * 1 / 2).toDoubleAsPrecision().ceil().toDouble();
    final double mixedClusterPerHourMoonlit =
        (platoonWeight * 100 * 2 / 3).toDoubleAsPrecision().ceil().toDouble();
    final double mixedClusterPerHourDark =
        (platoonWeight * 100 * 1 / 2).toDoubleAsPrecision().ceil().toDouble();
    final double trippedWirePerHourMoonlit =
        (platoonWeight * 75 * 2 / 3).toDoubleAsPrecision().ceil().toDouble();
    final double trippedWirePerHourDark =
        (platoonWeight * 75 * 1 / 2).toDoubleAsPrecision().ceil().toDouble();

    double darkTime;
    double moonLitTime;
    double remainingCluster = numberOfClusterPerStrip.toDouble();
    int currentDay = dDay;
    final double noOfTrippedWireOuterStrip =
        (numberOfClusterPerStrip / 2 * percentageOfTripWire / 100)
            .toDoubleAsPrecision()
            .ceil()
            .toDouble();
    double remainingTrippedWireCluster = noOfTrippedWireOuterStrip;
    final double timeAvailable = firstLight.differenceInMinutes(lastLight);
    var times = calculateMoonlitnDarkTime(dDay, timeAvailable);
    darkTime = times['darkTime'];
    moonLitTime = times['moonLitTime'];

    void calculateTimeForAntiTankCluster() {
      double estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime = (remainingCluster * 60 / antiTankClusterPerHourMoonlit)
            .toDoubleAsPrecision()
            .ceil()
            .toDouble();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (moonLitTime * antiTankClusterPerHourMoonlit / 60)
              .toDoubleAsPrecision()
              .ceil()
              .toDouble();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime = (remainingCluster * 60 / antiTankClusterPerHourDark)
            .toDoubleAsPrecision()
            .ceil()
            .toDouble();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (darkTime * antiTankClusterPerHourDark / 60)
              .toDoubleAsPrecision()
              .ceil()
              .toDouble();
          darkTime = 0;
          return;
        }
      }

      if (moonLitTime != 0 && darkTime != 0) {
        if (currentDay > 14) {
          calculateTimeForDark();
          if (remainingCluster > 0) {
            calculateTimeForMoonlit();
          }
        } else {
          calculateTimeForMoonlit();
          if (remainingCluster > 0) {
            calculateTimeForDark();
          }
        }
      } else if (moonLitTime != 0) {
        calculateTimeForMoonlit();
      } else if (darkTime != 0) {
        calculateTimeForDark();
      }
      if (remainingCluster > 0) {
        currentDay += 1;
        var times = calculateMoonlitnDarkTime(currentDay, timeAvailable);
        darkTime = times['darkTime'];
        moonLitTime = times['moonLitTime'];
        calculateTimeForAntiTankCluster();
      }
    }

    void calculateTimeForMixedCluster() {
      double estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime = (remainingCluster * 60 / mixedClusterPerHourMoonlit)
            .toDoubleAsPrecision()
            .ceil()
            .toDouble();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (moonLitTime * mixedClusterPerHourMoonlit / 60)
              .toDoubleAsPrecision()
              .ceil()
              .toDouble();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime = (remainingCluster * 60 / mixedClusterPerHourDark)
            .toDoubleAsPrecision()
            .ceil()
            .toDouble();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (darkTime * mixedClusterPerHourDark / 60)
              .toDoubleAsPrecision()
              .ceil()
              .toDouble();
          darkTime = 0;
          return;
        }
      }

      if (moonLitTime != 0 && darkTime != 0) {
        if (currentDay > 14) {
          calculateTimeForDark();
          if (remainingCluster > 0) {
            calculateTimeForMoonlit();
          }
        } else {
          calculateTimeForMoonlit();
          if (remainingCluster > 0) {
            calculateTimeForDark();
          }
        }
      } else if (moonLitTime != 0) {
        calculateTimeForMoonlit();
      } else if (darkTime != 0) {
        calculateTimeForDark();
      }
      if (remainingCluster > 0) {
        currentDay += 1;
        var times = calculateMoonlitnDarkTime(currentDay, timeAvailable);
        darkTime = times['darkTime'];
        moonLitTime = times['moonLitTime'];
        calculateTimeForMixedCluster();
      }
    }

    void calculateTimeForTrippedWireCluster() {
      double estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime =
            (remainingTrippedWireCluster * 60 / trippedWirePerHourMoonlit)
                .toDoubleAsPrecision()
                .ceil()
                .toDouble();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingTrippedWireCluster = 0;
          return;
        } else {
          remainingTrippedWireCluster -=
              (moonLitTime * trippedWirePerHourMoonlit / 60)
                  .toDoubleAsPrecision()
                  .ceil()
                  .toDouble();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime =
            (remainingTrippedWireCluster * 60 / trippedWirePerHourDark)
                .toDoubleAsPrecision()
                .ceil()
                .toDouble();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingTrippedWireCluster = 0;
          return;
        } else {
          remainingTrippedWireCluster -=
              (darkTime * trippedWirePerHourDark / 60)
                  .toDoubleAsPrecision()
                  .ceil()
                  .toDouble();
          darkTime = 0;
          return;
        }
      }

      if (moonLitTime != 0 && darkTime != 0) {
        if (currentDay > 14) {
          calculateTimeForDark();
          if (remainingTrippedWireCluster > 0) {
            calculateTimeForMoonlit();
          }
        } else {
          calculateTimeForMoonlit();
          if (remainingTrippedWireCluster > 0) {
            calculateTimeForDark();
          }
        }
      } else if (moonLitTime != 0) {
        calculateTimeForMoonlit();
      } else if (darkTime != 0) {
        calculateTimeForDark();
      }
      if (remainingTrippedWireCluster > 0) {
        currentDay += 1;
        var times = calculateMoonlitnDarkTime(currentDay, timeAvailable);
        darkTime = times['darkTime'];
        moonLitTime = times['moonLitTime'];
        calculateTimeForTrippedWireCluster();
      } else {
        remainingCluster -= noOfTrippedWireOuterStrip;
        calculateTimeForMixedCluster();
      }
    }

    for (int i = 0; i < numberOfStrips; i++) {
      if ((i == 0 || i == numberOfStrips - 1) &&
          typeOfOuterStrip == OuterStrip.TripWireCluster) {
        remainingCluster = numberOfClusterPerStrip.toDouble();
        remainingTrippedWireCluster = noOfTrippedWireOuterStrip;
        calculateTimeForTrippedWireCluster();
      } else if ((i == 0 || i == numberOfStrips - 1) &&
          typeOfOuterStrip == OuterStrip.MixedCluster) {
        calculateTimeForMixedCluster();
      } else if ((i != 0 && i != numberOfStrips - 1) ||
          typeOfOuterStrip == OuterStrip.AntiTankCluster) {
        remainingCluster = numberOfClusterPerStrip.toDouble();
        calculateTimeForAntiTankCluster();
      }
    }

    MinefieldTime minefieldTime = new MinefieldTime();
    minefieldTime.firstLight = firstLight;
    minefieldTime.lastLight = lastLight;
    minefieldTime.dayTaken = (currentDay - dDay);
    minefieldTime.timeAvailableADay = timeAvailable;
    minefieldTime.timeRequired = (currentDay - dDay) * timeAvailable +
        timeAvailable -
        (moonLitTime + darkTime);
    return minefieldTime;
  }

  Map<String, double> calculateMoonlitnDarkTime(int day, double timeAvailable) {
    double darkTime;
    double moonLitTime;
    if (day <= 14) {
      moonLitTime = (52 * day).toDouble();
      darkTime = (timeAvailable - moonLitTime) > 0
          ? (timeAvailable - moonLitTime)
          : 0.0;
    } else {
      darkTime = ((day - 14) * 52).toDouble();
      moonLitTime =
          (timeAvailable - darkTime) > 0 ? (timeAvailable - darkTime) : 0.0;
    }
    return {'moonLitTime': moonLitTime, 'darkTime': darkTime};
  }

  String minuteFormat(double minute) {
    if (minute > 60) {
      return "${(minute / 60).floor()} hours ${(minute % 60).floor()} minutes";
    } else {
      return "${minute.ceil()} minutes";
    }
  }

  String hourFormat(TimeOfDay time) {
    String hour = "00" + time.hour.toString();
    String minute = "00" + time.minute.toString();
    return (hour.substring(hour.length - 2) +
        minute.substring(minute.length - 2));
  }

  Fraction convertToFraction(String val) {
    return double.tryParse(val) != null
        ? Fraction.fromDouble(double.parse(val))
        : Fraction.fromString(val);
  }
}
