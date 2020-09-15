import './bridge_construction.dart';
import './grillage_construction.dart';
import './grillage_load.dart';
import './launching_data.dart';

enum TypesOfConstruction { SS, DS, DD, DT }

class BailyBridge {
  double waterGap;
  double distanceBtweenLaunchingLanding;
  double loadClassification;
  double pressureOfSoil;
  int additionalGrillage;
  Map<TypesOfConstruction, String> typesOfConstructionString = {
    TypesOfConstruction.SS: "SS",
    TypesOfConstruction.DS: "DS",
    TypesOfConstruction.DD: "DD",
    TypesOfConstruction.DT: "DT",
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
      waterGap + distanceBtweenLaunchingLanding + 3.5 + 3.5,
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

  List<int> get positionOfConstructionRoller {
    List<int> results = [];
    if (lengthOfBailyBridge >= 27) {
      results.add(27);
    }
    if (lengthOfBailyBridge >= 52) {
      results.add(52);
    }
    if (lengthOfBailyBridge >= 77) {
      results.add(77);
    }
    if (lengthOfBailyBridge >= 102) {
      results.add(102);
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

  double get weightOfJack => 0.5 * weightOfBB;

  int get numberOfJack {
    return _convertToNext(2, weightOfJack / 7.5);
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

  int _convertToNext(int type, double value) {
    return value % type != 0
        ? (value + type - (value % type)).round()
        : value.toInt();
  }
}
