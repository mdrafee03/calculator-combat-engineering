import './launching_data.dart';
import '../models/bridge_part.dart';
import '../models/launching_calc.dart';
import '../models/store_bridge.dart';
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

  // void removeUnusedGroundLevels() {
  //   [PositionRollers.Roller102, PositionRollers.Roller77].forEach((element) {
  //     if (existingGroundLevels.containsKey(element) &&
  //         !positionOfConstructionRoller.contains(element)) {
  //       existingGroundLevels.remove(element);
  //     } else if (!existingGroundLevels.containsKey(element) &&
  //         positionOfConstructionRoller.contains(element)) {
  //       existingGroundLevels[element] = 0;
  //     }
  //   });
  // }

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
    double farBank = waterGap;
    double row4Factor = (row1.farBank -
            existingGroundLevels[positionOfConstructionRoller.last]) /
        (firstPosition + farBank);

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
    var row5 = new LaunchingCalc(
      sl: 4,
      consideration: "Height of Launching plane from datum",
      roller102: row4.roller102 + 18,
      roller77: row4.roller77 + 18,
      roller52: row4.roller52 + 18,
      roller27: row4.roller27 + 18,
      roller3p5: row4.roller3p5 + 18,
      roller0: row4.roller0 + 18,
      farBank: row4.farBank + 18,
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
        typeOfConstructionOfNose[2] * 4;
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
}
