import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../shared/widgets/reference_text_pw.dart';
import '../../../../../shared/widgets/section_sub_heading_pw.dart';
import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/top_header_pw.dart';
import '../models/bridge_part.dart';
import '../models/launching_calc.dart';
import '../models/store_bridge.dart';
import '../widgets/store_cal_bb_widget_pw.dart';
import '../widgets/launching_calc_pw.dart';
import './launching_data.dart';
import './bridge_construction.dart';
import './grillage_construction.dart';
import './grillage_load.dart';

enum TypesOfConstruction { SS, DS, DD, DT }
enum PositionRollers {
  Roller102,
  Roller77,
  Roller52,
  Roller27,
  Roller3p5,
  Roller0,
  FarBank,
}

class BailyBridge {
  double waterGap;
  double distanceBetweenLaunchingNearbank;
  double distanceBetweenLandingFarbank;
  double loadClassification;
  double pressureOfSoil;
  int additionalGrillage;
  bool isLunching = false;
  Map<PositionRollers, double> existingGroundLevels = {
    PositionRollers.Roller102: 0,
    PositionRollers.Roller77: 0,
    PositionRollers.Roller52: 0,
    PositionRollers.Roller27: 0,
    PositionRollers.Roller3p5: 0,
    PositionRollers.Roller0: 0,
    PositionRollers.FarBank: 0,
  };
  Map<TypesOfConstruction, String> typesOfConstructionString = {
    TypesOfConstruction.SS: "SS",
    TypesOfConstruction.DS: "DS",
    TypesOfConstruction.DD: "DD",
    TypesOfConstruction.DT: "DT",
  };
  Map<PositionRollers, String> positionRollersString = {
    PositionRollers.Roller102: "102",
    PositionRollers.Roller77: "77",
    PositionRollers.Roller52: "52",
    PositionRollers.Roller27: "27",
    PositionRollers.Roller3p5: "3.5",
    PositionRollers.Roller0: "0",
    PositionRollers.FarBank: "far bank",
  };
  Map<PositionRollers, double> positionRollersNum = {
    PositionRollers.Roller102: 102,
    PositionRollers.Roller77: 77,
    PositionRollers.Roller52: 52,
    PositionRollers.Roller27: 27,
    PositionRollers.Roller3p5: 3.5,
    PositionRollers.Roller0: 0,
  };
  Map<TypesOfConstruction, double> weightPerBayForBridge = {
    TypesOfConstruction.SS: 1.92,
    TypesOfConstruction.DS: 2.49,
    TypesOfConstruction.DD: 3.59,
    TypesOfConstruction.DT: 5.09,
  };
  Map<TypesOfConstruction, double> weightPerBayForNose = {
    TypesOfConstruction.SS: 0.75,
    TypesOfConstruction.DS: 1.33,
    TypesOfConstruction.DD: 2.43,
  };

  double sag;
  final double sizeOfBaseplate = 13.4;

  int get lengthOfBailyBridge {
    return _convertToNext(
      10,
      waterGap +
          distanceBetweenLaunchingNearbank +
          distanceBetweenLandingFarbank +
          3.5 +
          3.5,
    );
  }

  TypesOfConstruction get typeOfConstructionOfBridge {
    BridgeConstruction row = BridgeConstruction.bridgeConstructions
        .firstWhere((element) => loadClassification <= element.load);
    if (lengthOfBailyBridge <= row.ss) {
      return TypesOfConstruction.SS;
    } else if (lengthOfBailyBridge <= row.ds) {
      return TypesOfConstruction.DS;
    } else if (lengthOfBailyBridge <= row.dd) {
      return TypesOfConstruction.DD;
    } else if (lengthOfBailyBridge <= row.dt) {
      return TypesOfConstruction.DT;
    } else {
      return null;
    }
  }

  int get lengthOfNose {
    return _convertToNext(10, lengthOfBailyBridge / 2 + 10);
  }

  List<int> get typeOfConstructionOfNose {
    LaunchingData selectedRow = LaunchingData
        .listOfLaunchingData[typeOfConstructionOfBridge]
        .firstWhere((element) => lengthOfBailyBridge <= element.span);
    sag = selectedRow.sag;
    return [
      selectedRow.baysForSS,
      selectedRow.baysForDS,
      selectedRow.baysForDD
    ];
  }

  int get lengthOfNoseCorrected {
    return typeOfConstructionOfNose.fold(
        0, (previousValue, element) => previousValue + element * 10);
  }

  int get positionOfLaunchingLink {
    return ((sag + 6) / 13.5).ceil() <= 4 ? ((sag + 6) / 13.5).ceil() : 4;
  }

  int get constructionSpaceRollerLayout {
    return lengthOfNoseCorrected + 27;
  }

  List<PositionRollers> get positionOfConstructionRoller {
    List<PositionRollers> results = [];
    if (lengthOfBailyBridge >= 27) {
      results.add(PositionRollers.Roller27);
    }
    if (lengthOfBailyBridge >= 52) {
      results.add(PositionRollers.Roller52);
    }
    if (lengthOfBailyBridge >= 77) {
      results.add(PositionRollers.Roller77);
    }
    if (lengthOfBailyBridge >= 102) {
      results.add(PositionRollers.Roller102);
    }
    return results;
  }

  List<Map<String, int>> get numberOfConstructionRollerEachSide {
    List<Map<String, int>> result = [];
    int numberOfRoller52 = 0;
    int numberOfRoller77 = 0;
    int numberOfRoller102 = 0;
    if (typeOfConstructionOfBridge == TypesOfConstruction.SS) {
      numberOfRoller52 = 1;
    } else if (typeOfConstructionOfBridge == TypesOfConstruction.DS) {
      if (lengthOfBailyBridge <= 80) {
        numberOfRoller52 = 1;
      } else {
        numberOfRoller52 = 2;
      }
    } else {
      numberOfRoller52 = 2;
    }

    if (typeOfConstructionOfBridge == TypesOfConstruction.SS ||
        typeOfConstructionOfBridge == TypesOfConstruction.DS) {
      if (lengthOfBailyBridge <= 120) {
        numberOfRoller77 = 1;
      } else {
        numberOfRoller77 = 2;
      }
    } else {
      if (lengthOfBailyBridge <= 80) {
        numberOfRoller77 = 1;
      } else {
        numberOfRoller77 = 2;
      }
    }

    if (typeOfConstructionOfBridge == TypesOfConstruction.DD ||
        typeOfConstructionOfBridge == TypesOfConstruction.DT) {
      if (lengthOfBailyBridge <= 120) {
        numberOfRoller102 = 1;
      } else {
        numberOfRoller102 = 2;
      }
    }

    result.add({"27": 1});
    result.add({"52": numberOfRoller52});
    result.add({"77": numberOfRoller77});
    result.add({"102": numberOfRoller102});

    return result;
  }

  double get weightOfBB {
    return weightPerBayForBridge[typeOfConstructionOfBridge] *
        (lengthOfBailyBridge / 10);
  }

  double get weightOfNose {
    double result = 0;
    typeOfConstructionOfNose.asMap().forEach((i, element) {
      switch (i) {
        case 0:
          result += weightPerBayForNose[TypesOfConstruction.SS] * element;
          return;
        case 1:
          result += weightPerBayForNose[TypesOfConstruction.DS] * element;
          return;
        case 2:
          result += weightPerBayForNose[TypesOfConstruction.DD] * element;
          return;
        default:
          result += 0;
          return;
      }
    });
    return result;
  }

  int get rockingRoller {
    if (typeOfConstructionOfBridge == TypesOfConstruction.SS ||
        typeOfConstructionOfBridge == TypesOfConstruction.DS) {
      return 15;
    } else {
      return 21;
    }
  }

  int get numberOfLaunchingRoller {
    return _convertToNext(2, (weightOfBB + weightOfNose) / rockingRoller);
  }

  int get numberOfLandingRoller {
    return _convertToNext(2, (0.5 * weightOfBB + weightOfNose) / rockingRoller);
  }

  int get plainRoller {
    return numberOfConstructionRollerEachSide.fold(0,
            (previousValue, element) => previousValue + element.values.first) *
        2;
  }

  int get totalRoller {
    return numberOfLaunchingRoller + numberOfLandingRoller + plainRoller;
  }

  double get maxReactionOfBasePlate {
    int selectedIndex;
    int index1 = GrillageConstruction.grillageConstructions
        .indexWhere((element) => lengthOfBailyBridge <= element.span);
    if (GrillageConstruction.grillageConstructions[index1].type ==
        typeOfConstructionOfBridge) {
      selectedIndex = index1;
    } else {
      int index2 = GrillageConstruction.grillageConstructions
          .indexWhere((element) => typeOfConstructionOfBridge == element.type);
      selectedIndex = index1 > index2 ? index1 : index2;
    }
    return GrillageConstruction
        .grillageConstructions[selectedIndex].maxBaseplate;
  }

  double get maxPressureOnSoil {
    return maxReactionOfBasePlate / sizeOfBaseplate;
  }

  bool get isGrillageRequire {
    return maxPressureOnSoil > pressureOfSoil;
  }

  GrillageLoad get getGrillageLoads {
    return GrillageLoad.grillageLoads.firstWhere((element) =>
        element.pressureOfSoil == pressureOfSoil &&
        maxReactionOfBasePlate <= element.basePlate);
  }

  int get numberOfGrillage {
    return 4 + additionalGrillage;
  }

  double get weightOfJack => 0.5 * weightOfBB;

  int get numberOfJack {
    return _convertToNext(2, weightOfJack / 7.5);
  }

  List<LaunchingCalc> get launchingCalculations {
    List<LaunchingCalc> launchingCalcs = [];
    var row1 = new LaunchingCalc(
      sl: 1,
      consideration: "Existing Ground Level (inch)",
      roller102: existingGroundLevels[PositionRollers.Roller102],
      roller77: existingGroundLevels[PositionRollers.Roller77],
      roller52: existingGroundLevels[PositionRollers.Roller52],
      roller27: existingGroundLevels[PositionRollers.Roller27],
      roller3p5: existingGroundLevels[PositionRollers.Roller3p5],
      roller0: existingGroundLevels[PositionRollers.Roller0],
      farBank: existingGroundLevels[PositionRollers.FarBank],
    );
    var row2 = new LaunchingCalc(
      sl: 2,
      consideration: "Height of Roller (inch)",
      roller102: 8,
      roller77: 8,
      roller52: 8,
      roller27: 8,
      roller3p5: 4,
      roller0: 16.5,
      farBank: 16.5,
    );
    var row3 = new LaunchingCalc(
      sl: 3,
      consideration: "Tip of Roller (inch)",
      roller102: row1.roller102 + row2.roller102,
      roller77: row1.roller77 + row2.roller77,
      roller52: row1.roller52 + row2.roller52,
      roller27: row1.roller27 + row2.roller27,
      roller3p5: row1.roller3p5 + row2.roller3p5,
      roller0: row1.roller0 + row2.roller0,
      farBank: row1.farBank + row2.farBank,
    );
    double firstPosition =
        positionRollersNum[positionOfConstructionRoller.last];
    double firstPositionGroundLevel =
        existingGroundLevels[positionOfConstructionRoller.last];
    double farBank = waterGap;
    double row4Factor =
        (row1.farBank - firstPositionGroundLevel) / (firstPosition + farBank);

    var row4 = new LaunchingCalc(
      sl: 4,
      consideration: "Height of Launching plane above tail End",
      roller102: row4Factor * (firstPosition - 102),
      roller77: row4Factor * (firstPosition - 77),
      roller52: row4Factor * (firstPosition - 52),
      roller27: row4Factor * (firstPosition - 27),
      roller3p5: row4Factor * (firstPosition - 3.5),
      roller0: row4Factor * (firstPosition - 0),
      farBank: row4Factor * (firstPosition + farBank),
    );
    double row5Factor = firstPositionGroundLevel + 6;
    var row5 = new LaunchingCalc(
      sl: 4,
      consideration: "Height of Launching plane from datum",
      roller102: row4.roller102 + row5Factor,
      roller77: row4.roller77 + row5Factor,
      roller52: row4.roller52 + row5Factor,
      roller27: row4.roller27 + row5Factor,
      roller3p5: row4.roller3p5 + row5Factor,
      roller0: row4.roller0 + row5Factor,
      farBank: row4.farBank + row5Factor,
    );
    var row6 = new LaunchingCalc(
      sl: 4,
      consideration: "Excavation/filling",
      roller102: row3.roller102 - row5.roller102,
      roller77: row3.roller77 - row5.roller77,
      roller52: row3.roller52 - row5.roller52,
      roller27: row3.roller27 - row5.roller27,
      roller3p5: row3.roller3p5 - row5.roller3p5,
      roller0: row3.roller0 - row5.roller0,
      farBank: row3.farBank - row5.farBank,
    );
    launchingCalcs.addAll([row1, row2, row3, row4, row5, row6]);
    return launchingCalcs;
  }

  int get bridgeBay => (lengthOfBailyBridge / 10).round();

  List<int> get mainBarFactor {
    List<int> mainBar = [0, 0, 0];
    int divided = (bridgeBay / 3).ceil();
    if (bridgeBay <= 1) {
      mainBar[0] = bridgeBay;
    } else {
      mainBar[0] = divided;
      mainBar[1] = ((bridgeBay - divided) / 2).ceil();
      mainBar[2] = bridgeBay - mainBar[0] - mainBar[1];
    }
    return mainBar;
  }

  List<StoreBridge> get storeCalculation {
    List<StoreBridge> listOfStoreBridges = [];
    var type = typeOfConstructionOfBridge;

    List<int> part(int index) => [
          BridgePart.listOfBridgePart[index].head[type],
          BridgePart.listOfBridgePart[index].intermediate[type],
          BridgePart.listOfBridgePart[index].tail[type],
        ];
    int partWithFactor(int partIndex, int index) =>
        part(partIndex)[index] * mainBarFactor[index];
    int sumWithFactor(int partIndex) =>
        partWithFactor(partIndex, 0) +
        partWithFactor(partIndex, 1) +
        partWithFactor(partIndex, 2);

    int baseplatSum =
        part(0).fold(0, (previousValue, element) => previousValue + element);
    var row1 = new StoreBridge(
      sl: "1",
      name: "Baseplate",
      head: part(0)[0],
      intermediate: part(0)[1],
      tail: part(0)[2],
      nose: 0,
      total: baseplatSum,
      percentage: (baseplatSum * 0.1).ceil(),
      grandTotal: (baseplatSum * 1.1).ceil(),
    );

    var row2 = new StoreBridge(
      sl: "2",
      name: "Bearer, Footwalk",
      head: partWithFactor(1, 0),
      intermediate: partWithFactor(1, 1),
      tail: partWithFactor(1, 2),
      nose: 0,
      total: sumWithFactor(1),
      percentage: (sumWithFactor(1) * 0.1).ceil(),
      grandTotal: (sumWithFactor(1) * 1.1).ceil(),
    );

    int panelNose = typeOfConstructionOfNose[0] * 2 +
        typeOfConstructionOfNose[1] * 4 +
        typeOfConstructionOfNose[2] * 8;
    int panelSum = sumWithFactor(2) + panelNose;
    var row3 = new StoreBridge(
      sl: "3",
      name: "Panel",
      head: partWithFactor(2, 0),
      intermediate: partWithFactor(2, 1),
      tail: partWithFactor(2, 2),
      nose: panelNose,
      total: panelSum,
      percentage: (panelSum * 0.1).ceil(),
      grandTotal: (panelSum * 1.1).ceil(),
    );
    var row4 = new StoreBridge(
      sl: "4",
      name: "End post",
      head: partWithFactor(3, 0),
      intermediate: partWithFactor(3, 1),
      tail: partWithFactor(3, 2),
      nose: 0,
      total: sumWithFactor(3),
      percentage: (sumWithFactor(3) * 0.1).ceil(),
      grandTotal: (sumWithFactor(3) * 1.1).ceil(),
    );

    int noseForRakerAndSwayBrace =
        ((lengthOfNoseCorrected / 10).round() - 2) * 2;
    int rakerSum = sumWithFactor(4) + noseForRakerAndSwayBrace;
    var row5 = new StoreBridge(
      sl: "5",
      name: "Raker",
      head: partWithFactor(4, 0),
      intermediate: partWithFactor(4, 1),
      tail: partWithFactor(4, 2),
      nose: noseForRakerAndSwayBrace,
      total: rakerSum,
      percentage: (rakerSum * 0.1).ceil(),
      grandTotal: (rakerSum * 1.1).ceil(),
    );
    int swayBraceSum = sumWithFactor(5) + noseForRakerAndSwayBrace;
    var row6 = new StoreBridge(
      sl: "6",
      name: "Sway Brace",
      head: partWithFactor(5, 0),
      intermediate: partWithFactor(5, 1),
      tail: partWithFactor(5, 2),
      nose: noseForRakerAndSwayBrace,
      total: swayBraceSum,
      percentage: (swayBraceSum * 0.1).ceil(),
      grandTotal: (swayBraceSum * 1.1).ceil(),
    );
    var row7 = new StoreBridge(
      sl: "7",
      name: "Stringer, button",
      head: partWithFactor(6, 0),
      intermediate: partWithFactor(6, 1),
      tail: partWithFactor(6, 2),
      nose: 0,
      total: sumWithFactor(6),
      percentage: (sumWithFactor(6) * 0.1).ceil(),
      grandTotal: (sumWithFactor(6) * 1.1).ceil(),
    );
    var row8 = new StoreBridge(
      sl: "8",
      name: "Stringer, plain",
      head: partWithFactor(7, 0),
      intermediate: partWithFactor(7, 1),
      tail: partWithFactor(7, 2),
      nose: 0,
      total: sumWithFactor(7),
      percentage: (sumWithFactor(7) * 0.1).ceil(),
      grandTotal: (sumWithFactor(7) * 1.1).ceil(),
    );
    int transonSum = sumWithFactor(8) + (lengthOfNoseCorrected / 10).round();
    var row9 = new StoreBridge(
      sl: "9",
      name: "Transons",
      head: partWithFactor(8, 0),
      intermediate: partWithFactor(8, 1),
      tail: partWithFactor(8, 2),
      nose: 9,
      total: transonSum,
      percentage: (transonSum * 0.1).ceil(),
      grandTotal: (transonSum * 1.1).ceil(),
    );

    listOfStoreBridges
        .addAll([row1, row2, row3, row4, row5, row6, row7, row8, row9]);
    return listOfStoreBridges;
  }

  int get lorryForPanels {
    return (storeCalculation[2].grandTotal / 12).ceil();
  }

  int get lorryForDecking {
    return (bridgeBay / 2 * 1.1).ceil();
  }

  int get lorryForGrillage {
    return (numberOfGrillage / 2).ceil();
  }

  int get totalLorry {
    return lorryForPanels +
        lorryForDecking +
        2 +
        (isGrillageRequire ? lorryForGrillage : 0);
  }

  int _convertToNext(int type, double value) {
    return value % type != 0
        ? (value + type - (value % type)).round()
        : value.toInt();
  }

  Future<void> generatePDF(Document doc) async {
    final slForParent = SerialManage();
    final slForVehicle = SerialManage();
    final PdfImage image1 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/baily-bridge/bb1.jpg'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image2 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/baily-bridge/bb2.jpg'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image3 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/baily-bridge/bb2.jpg'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of Baily Bridge'),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionSubHeadingPw(
                    "${slForParent.serialNum} .",
                    "Lenght of Baily Bridge and Type of Construction",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Length of Baily Bridge = $lengthOfBailyBridge ft",
                        ),
                        Text(
                          "b. Type of Construction of Baily Bridge = ${typesOfConstructionString[typeOfConstructionOfBridge]}",
                        ),
                        ReferenceTextPw(
                          "(Auth: ERPB-1964, Section 16, Para 6, Table 1)",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SectionSubHeadingPw(
                    "${slForParent.serialNum} .",
                    "Launching Nose and Position of Launching Link",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Length of Nose = $lengthOfNose ft = ${(lengthOfNose / 10).round()} Bay ",
                        ),
                        Wrap(
                          children: [
                            Text(
                              "b. Type of Construction of of Nose = ${typeOfConstructionOfNose[0]} SS",
                            ),
                            if (typeOfConstructionOfNose[1] != 0)
                              Text(
                                " and ${typeOfConstructionOfNose[1]} DS",
                              ),
                            if (typeOfConstructionOfNose[2] != 0)
                              Text(
                                " and ${typeOfConstructionOfNose[2]} DD",
                              ),
                          ],
                        ),
                        ReferenceTextPw(
                            "(Authorization: ME Volume III, Part III, Figure 33, 34, 35, or 36), Page 149-152"),
                        Text(
                          "c. Corrected Length of Nose = $lengthOfNoseCorrected ft = ${(lengthOfNose / 10).round()} Bay ",
                        ),
                        ReferenceTextPw(
                            "(Authorization: ME Volume III, Part III, Figure 33, 34, 35, or 36), Page 149-152"),
                        Text(
                          "d. Position of Launching Link = $positionOfLaunchingLink Bay ",
                        ),
                        ReferenceTextPw(
                          "[Auth: ME Volume III, Part III, Section 8, Para 3a] (Page-33)",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SectionSubHeadingPw(
                    "${slForParent.serialNum} .",
                    "Roller Layout",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Construction Space = $constructionSpaceRollerLayout ft",
                        ),
                        Text(
                          "b. Position of Construction Roller = At a Distance of ${positionOfConstructionRoller.sublist(0, positionOfConstructionRoller.length - 1).map((element) => positionRollersString[element]).join("', ")}' and ${positionRollersString[positionOfConstructionRoller.last]}'",
                        ),
                        ReferenceTextPw(
                          "[Auth: ME Volume III, Part III, Section 8, Part 3a] (Page-33)",
                        ),
                        Row(
                          children: [
                            Text("c. "),
                            Text(
                              "No. of Construction rollers at each side",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          alignment: Alignment.topLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: numberOfConstructionRollerEachSide
                                  .asMap()
                                  .map((i, element) => MapEntry(
                                      i,
                                      Text(
                                          "(${i + 1}) At ${element.keys.first}' : ${element.values.first} Nos")))
                                  .values
                                  .toList()),
                        ),
                        ReferenceTextPw(
                          "(Auth: ERPB Section 16 Para 4c, Page-67; ME Volumne III, Part III, Section 6, Para -4, Page-30)",
                        ),
                        Text(
                          "d. No. of Launching Roller = $numberOfLaunchingRoller Nos",
                        ),
                        ReferenceTextPw(
                          "[Auth: ME Volumne III, Part III, Annex A (Page-132) and Section 4, Para 1 (Page-29), Section 6, Para 2 & ERPB Section 16 Para 2 (Page-66)]",
                        ),
                        Text(
                          "e. No. of Landing Roller = $numberOfLandingRoller Nos",
                        ),
                        ReferenceTextPw(
                          "(Auth: ME Volume III, Part III, Section 6, Para-3)",
                        ),
                        Row(
                          children: [
                            Text("f. "),
                            Text(
                              "Total Required of Rollers",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Rocking Rollers = ${numberOfLaunchingRoller + numberOfLandingRoller} Nos",
                              ),
                              Text(
                                "(2) Plain Rollers = $plainRoller Nos",
                              ),
                              Text(
                                "(3) Total Rollers = $totalRoller Nos",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SectionSubHeadingPw(
                    "${slForParent.serialNum} .",
                    "Grillage",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Maximum base plate reaction = $maxReactionOfBasePlate ton",
                        ),
                        ReferenceTextPw(
                          "(Auth: ERPB, Section 16, table under para 13) (Page-83)",
                        ),
                        Text(
                          "b. Size of the Baseplate  = $sizeOfBaseplate sq ft",
                        ),
                        ReferenceTextPw("(Auth: ERPB, Section 16, Para 03)"),
                        Text(
                          "c. Given Bearing pressure on soil  = $pressureOfSoil ton/sq ft",
                        ),
                        Text(
                          "d. Max Bearing Pressure on soil  = ${maxPressureOnSoil.toStringAsFixed(2)} ton/sq ft",
                        ),
                        isGrillageRequire
                            ? Text("e. Grillage is required")
                            : Text("e. Grillage is not required"),
                        if (isGrillageRequire)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "f. Type of Grillage = ${getGrillageLoads.type}, Baseplate = ${getGrillageLoads.basePlate}, template = ${getGrillageLoads.template},",
                              ),
                              Text(
                                "g. Total no of Grillage = $numberOfGrillage Nos",
                              ),
                            ],
                          ),
                        ReferenceTextPw(
                            "(Auth: ME Volume III, Part III, Fig: 37"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SectionSubHeadingPw(
                    "${slForParent.serialNum} .",
                    "Jacks",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a .Weight on Jack = ${weightOfJack.toStringAsFixed(2)} tons",
                        ),
                        Text(
                          "b. No of Jack require = $numberOfJack Nos",
                        ),
                        ReferenceTextPw(
                          "(Auth: ME Volume III part III, Section: 15, Para 1) (Page-42)",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  if (isLunching)
                    LaunchingCalcBailyBridgePw(
                      sl: slForParent.serialNum,
                      lauchings: launchingCalculations,
                      positions: positionOfConstructionRoller,
                      farbank: waterGap,
                    ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  StoreCalcBBWidgetPw(
                    sl: slForParent.serialNum,
                    stores: storeCalculation,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SectionSubHeadingPw(
                      "${slForParent.serialNum} .", "Vehicle Require"),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${slForVehicle.serial}. Lorry for Panels = $lorryForPanels",
                        ),
                        Text(
                          "${slForVehicle.serial}. Lorry for Decking  = $lorryForDecking",
                        ),
                        Text(
                          "${slForVehicle.serial}. Ramps  = 2 x Lorry",
                        ),
                        if (isGrillageRequire)
                          Text(
                            "${slForVehicle.serial}. Grillage  = $lorryForGrillage",
                          ),
                        Text(
                          "${slForVehicle.serial}. Total Lorry= $totalLorry",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Image(image1),
            Image(image2),
            Image(image3),
          ];
        },
      ),
    );
  }

  void savePDF(m.BuildContext ctx) async {
    var doc = Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File("$directory/Baily-Bridge.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Baily-Bridge.pdf');
  }
}
