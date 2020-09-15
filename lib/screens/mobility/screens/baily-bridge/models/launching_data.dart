import './baily_bridge.dart';

class LaunchingData {
  int span;
  int load;
  int baysForSS;
  int baysForDS;
  int baysForDD;
  double sag;
  LaunchingData(this.span, this.load, this.baysForSS, this.baysForDS,
      this.baysForDD, this.sag);
  static List<LaunchingData> launchingDataForSS = [
    LaunchingData(30, 40, 2, 0, 0, 3),
    LaunchingData(40, 30, 3, 0, 0, 4),
    LaunchingData(50, 30, 3, 0, 0, 5.5),
    LaunchingData(60, 24, 4, 0, 0, 8),
    LaunchingData(70, 12, 5, 0, 0, 11),
    LaunchingData(80, 12, 5, 0, 0, 16),
    LaunchingData(90, 9, 6, 0, 0, 24),
  ];
  static List<LaunchingData> launchingDataForDS = [
    LaunchingData(40, 70, 2, 0, 0, 2.5),
    LaunchingData(50, 60, 3, 0, 0, 4.5),
    LaunchingData(60, 50, 4, 0, 0, 7.5),
    LaunchingData(70, 40, 4, 0, 0, 11),
    LaunchingData(80, 40, 5, 0, 0, 15),
    LaunchingData(90, 30, 6, 0, 0, 20),
    LaunchingData(100, 30, 6, 0, 0, 25),
    LaunchingData(110, 24, 7, 0, 0, 31),
    LaunchingData(120, 12, 7, 0, 0, 38),
    LaunchingData(130, 12, 8, 0, 0, 47),
    LaunchingData(140, 12, 8, 0, 0, 58),
    LaunchingData(150, 9, 9, 0, 0, 70),
  ];
  static List<LaunchingData> launchingDataForDD = [
    LaunchingData(80, 70, 5, 0, 0, 12),
    LaunchingData(90, 70, 6, 0, 0, 14),
    LaunchingData(100, 60, 6, 0, 0, 17),
    LaunchingData(110, 50, 7, 0, 0, 21),
    LaunchingData(120, 40, 7, 0, 0, 25),
    LaunchingData(130, 40, 8, 0, 0, 30),
    LaunchingData(140, 30, 8, 1, 0, 37),
    LaunchingData(150, 24, 7, 2, 0, 43),
    LaunchingData(160, 18, 8, 2, 0, 50),
    LaunchingData(170, 12, 8, 2, 0, 58),
    LaunchingData(180, 9, 8, 3, 0, 66),
  ];
  static List<LaunchingData> launchingDataForDT = [
    LaunchingData(120, 70, 5, 2, 0, 19),
    LaunchingData(130, 60, 5, 2, 0, 23),
    LaunchingData(140, 50, 6, 2, 0, 27),
    LaunchingData(150, 50, 6, 3, 0, 36),
    LaunchingData(160, 50, 6, 3, 0, 39),
    LaunchingData(170, 40, 6, 4, 0, 49),
    LaunchingData(180, 40, 6, 4, 1, 56),
    LaunchingData(190, 30, 6, 4, 1, 72),
    LaunchingData(200, 18, 6, 4, 1, 81),
  ];
  static Map<TypesOfConstruction, List<LaunchingData>> listOfLaunchingData = {
    TypesOfConstruction.SS: launchingDataForSS,
    TypesOfConstruction.DS: launchingDataForDS,
    TypesOfConstruction.DD: launchingDataForDD,
    TypesOfConstruction.DT: launchingDataForDT,
  };
}
