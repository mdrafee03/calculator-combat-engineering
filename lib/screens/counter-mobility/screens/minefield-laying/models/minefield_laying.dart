import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:fraction/fraction.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/top_header_pw.dart';
import '../../../../../shared//extension-methods/double_apis.dart';
import '../../../../../shared//extension-methods/timeOfDay_apis.dart';
import './minefield_time.dart';
import './moon_lit.dart';

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
  int numberOfMixedStrip;
  int numberOfIOEGroup;
  int numberOfClusterPerGroup;
  int totalTurningPointsPerStrip;
  int noOfFieldEngineerPlatoon;
  int noOfInfantryPlatoon;
  int noOfAssistedByInfantryPlatoon;
  double percentageOfTripWire;
  int noOfantiTankMinePerLorry;
  int noOfantiPersonnelMinePerLorry;
  OuterStrip typeOfOuterStrip;
  int dDay;
  m.TimeOfDay firstLight = m.TimeOfDay.now();
  m.TimeOfDay lastLight = m.TimeOfDay.now();

  int get numberOfStrips {
    return (density / standardDensity).toDouble().toDoubleAsPrecision().ceil();
  }

  int get numberOfAntiTankStrips {
    return (numberOfStrips - numberOfMixedStrip).ceil();
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
    return (antiTankMines / noOfantiTankMinePerLorry)
        .toDoubleAsPrecision()
        .ceil();
  }

  int get totalLorryForAntiPersonnelMine {
    return (antiPersonnelMines / noOfantiPersonnelMinePerLorry)
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

  int get totalTransportRequired {
    return totalLorryForPersonnel +
        totalLorryForAntiTankMine +
        totalLorryForAntiPersonnelMine +
        totalLorryForStores;
  }

  double get platoonWeight {
    return (noOfFieldEngineerPlatoon +
        0.5 * noOfInfantryPlatoon +
        1.5 * noOfAssistedByInfantryPlatoon);
  }

  MinefieldTime get timeRequired {
    final int antiTankClusterPerHourMoonlit =
        (platoonWeight * 200 * 2 / 3).toDoubleAsPrecision().ceil();
    final int antiTankClusterPerHourDark =
        (platoonWeight * 200 * 1 / 2).toDoubleAsPrecision().ceil();
    final int mixedClusterPerHourMoonlit =
        (platoonWeight * 100 * 2 / 3).toDoubleAsPrecision().ceil();
    final int mixedClusterPerHourDark =
        (platoonWeight * 100 * 1 / 2).toDoubleAsPrecision().ceil();
    final int trippedWirePerHourMoonlit =
        (platoonWeight * 75 * 2 / 3).toDoubleAsPrecision().ceil();
    final int trippedWirePerHourDark =
        (platoonWeight * 75 * 1 / 2).toDoubleAsPrecision().ceil();

    int darkTime;
    int moonLitTime;
    int remainingCluster = numberOfClusterPerStrip;
    int currentDay = dDay;
    final int noOfTrippedWireOuterStrip =
        (numberOfClusterPerStrip / 2 * percentageOfTripWire / 100)
            .toDoubleAsPrecision()
            .ceil();
    int remainingTrippedWireCluster = noOfTrippedWireOuterStrip;
    final int timeAvailable = firstLight - lastLight;
    var times = calculateMoonlitnDarkTime(dDay, timeAvailable);
    darkTime = times['darkTime'];
    moonLitTime = times['moonLitTime'];

    void calculateTimeForAntiTankCluster() {
      int estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime = (remainingCluster * 60 / antiTankClusterPerHourMoonlit)
            .toDoubleAsPrecision()
            .ceil();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (moonLitTime * antiTankClusterPerHourMoonlit / 60)
              .toDoubleAsPrecision()
              .ceil();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime = (remainingCluster * 60 / antiTankClusterPerHourDark)
            .toDoubleAsPrecision()
            .ceil();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (darkTime * antiTankClusterPerHourDark / 60)
              .toDoubleAsPrecision()
              .ceil();
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
      int estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime = (remainingCluster * 60 / mixedClusterPerHourMoonlit)
            .toDoubleAsPrecision()
            .ceil();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (moonLitTime * mixedClusterPerHourMoonlit / 60)
              .toDoubleAsPrecision()
              .ceil();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime = (remainingCluster * 60 / mixedClusterPerHourDark)
            .toDoubleAsPrecision()
            .ceil();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingCluster = 0;
          return;
        } else {
          remainingCluster -= (darkTime * mixedClusterPerHourDark / 60)
              .toDoubleAsPrecision()
              .ceil();
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
      int estimatedTime;
      void calculateTimeForMoonlit() {
        estimatedTime =
            (remainingTrippedWireCluster * 60 / trippedWirePerHourMoonlit)
                .toDoubleAsPrecision()
                .ceil();
        if (estimatedTime <= moonLitTime) {
          moonLitTime -= estimatedTime;
          remainingTrippedWireCluster = 0;
          return;
        } else {
          remainingTrippedWireCluster -=
              (moonLitTime * trippedWirePerHourMoonlit / 60)
                  .toDoubleAsPrecision()
                  .ceil();
          moonLitTime = 0;
          return;
        }
      }

      void calculateTimeForDark() {
        estimatedTime =
            (remainingTrippedWireCluster * 60 / trippedWirePerHourDark)
                .toDoubleAsPrecision()
                .ceil();
        if (estimatedTime <= darkTime) {
          darkTime -= estimatedTime;
          remainingTrippedWireCluster = 0;
          return;
        } else {
          remainingTrippedWireCluster -=
              (darkTime * trippedWirePerHourDark / 60)
                  .toDoubleAsPrecision()
                  .ceil();
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
        remainingCluster = numberOfClusterPerStrip;
        remainingTrippedWireCluster = noOfTrippedWireOuterStrip;
        calculateTimeForTrippedWireCluster();
      } else if ((i == 0 || i == numberOfStrips - 1) &&
          typeOfOuterStrip == OuterStrip.MixedCluster) {
        calculateTimeForMixedCluster();
      } else if ((i != 0 && i != numberOfStrips - 1) ||
          typeOfOuterStrip == OuterStrip.AntiTankCluster) {
        remainingCluster = numberOfClusterPerStrip;
        calculateTimeForAntiTankCluster();
      }
    }

    MinefieldTime minefieldTime = MinefieldTime();
    minefieldTime.firstLight = firstLight;
    minefieldTime.lastLight = lastLight;
    minefieldTime.dayTaken = (currentDay - dDay);
    minefieldTime.timeAvailableADay = timeAvailable;
    minefieldTime.timeRequired = (currentDay - dDay) * timeAvailable +
        timeAvailable -
        (moonLitTime + darkTime);
    minefieldTime.totalTimeRequired = minefieldTime.timeRequired / 60 / 4;
    return minefieldTime;
  }

  Map<String, int> calculateMoonlitnDarkTime(int day, int timeAvailable) {
    int darkTime;
    int moonLitTime;
    if (day <= 14) {
      moonLitTime = (52 * day);
      darkTime =
          (timeAvailable - moonLitTime) > 0 ? (timeAvailable - moonLitTime) : 0;
    } else {
      darkTime = (day - 14) * 52;
      moonLitTime =
          (timeAvailable - darkTime) > 0 ? (timeAvailable - darkTime) : 0;
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

  String hourFormat(m.TimeOfDay time) {
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

  Future<void> generatePDF(Document doc) async {
    final PdfImage image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/minefield_layout.jpg'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of the minefield laying calculation'),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('1. ', 'Strips'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Number of Strips = $numberOfStrips",
                        ),
                        Text(
                          "b. Number of Anti-Tank Strips = $numberOfAntiTankStrips",
                        ),
                        Text(
                          "c. Number of Mixed Strips = $numberOfMixedStrip",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('2. ', 'Mines'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Number of Anti-Tank Mines = $antiTankMines",
                        ),
                        Text(
                          "b. Number of Anti-Personnel Mines = $antiPersonnelMines",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('3. ', 'Stores'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Long Pickets = $longPicket",
                        ),
                        Text(
                          "b. Short Pickets = $shortPicket",
                        ),
                        Text(
                          "c. Barbed Wire = $barbedWire",
                        ),
                        Text(
                          "d. Perimeter Sign Posting = $perimeterSignPosting",
                        ),
                        Text(
                          "e. Tracing Tape = $tracingTape",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('4. ', 'Transport'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. For Anti-Tank Mines = ${totalLorryForAntiTankMine}x 3-ton lorry",
                        ),
                        Text(
                          "b. For Anti-Personnel Mines = ${totalLorryForAntiPersonnelMine}x 3-ton lorry",
                        ),
                        Text(
                          "c. For Perimeter Fencing = ${totalLorryForStores}x 3-ton lorry",
                        ),
                        Wrap(
                          children: [
                            Text("d. For Personnel "),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "= ${totalLorryForPersonnel}x 3-ton lorry",
                                ),
                                Text("= 1x 1/4-ton Jeep"),
                                Text("= 1x 1-ton pickup"),
                                Text("= 1x Ambulance"),
                              ],
                            )
                          ],
                        ),
                        Text(
                          "e. Total 3-ton Require = $totalTransportRequired",
                        ),
                        Wrap(
                          children: [
                            Text("f. Total Other Vehicles Require"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("= 1x 1/4-ton Jeep"),
                                Text("= 1x 1-ton pickup"),
                                Text("= 1x Ambulance"),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('5. ', 'Time'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Start Time = ${hourFormat(lastLight)} D-Day (${MoonLit.listOfMoonlit.firstWhere((option) => option.value == dDay).title})",
                        ),
                        Text(
                          "b. Completion Time = ${timeRequired.completionTime}",
                        ),
                        Text(
                          "c. Total Time Require = ${timeRequired.timeRequiredInMinutes}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('6. ', 'Layout of Conventional Minefield'),
                  Container(
                    child: Image(image),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  void savePDF(m.BuildContext ctx) async {
    var doc = Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File(
        "$directory/Minefield-Laying${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Minefield-Laying.pdf');
  }
}
