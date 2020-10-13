import './baily_bridge.dart';

class GrillageConstruction {
  int span;
  TypesOfConstruction type;
  double maxBaseplate;
  GrillageConstruction(this.span, this.type, this.maxBaseplate);

  static List<GrillageConstruction> grillageConstructions = [
    GrillageConstruction(30, TypesOfConstruction.SS, 20.8),
    GrillageConstruction(40, TypesOfConstruction.SS, 21.8),
    GrillageConstruction(40, TypesOfConstruction.DS, 22.2),
    GrillageConstruction(50, TypesOfConstruction.DS, 23.3),
    GrillageConstruction(60, TypesOfConstruction.DS, 24.2),
    GrillageConstruction(70, TypesOfConstruction.DS, 25.1),
    GrillageConstruction(80, TypesOfConstruction.DS, 25.9),
    GrillageConstruction(90, TypesOfConstruction.DD, 30.7),
    GrillageConstruction(100, TypesOfConstruction.DD, 32.9),
    GrillageConstruction(110, TypesOfConstruction.DD, 35.3),
    GrillageConstruction(120, TypesOfConstruction.DD, 37.6),
    GrillageConstruction(130, TypesOfConstruction.DD, 39.9),
    GrillageConstruction(140, TypesOfConstruction.DT, 47.5),
    GrillageConstruction(150, TypesOfConstruction.DT, 49.4),
    GrillageConstruction(160, TypesOfConstruction.DT, 51.2),
    GrillageConstruction(170, TypesOfConstruction.DT, 53.1),
    GrillageConstruction(180, TypesOfConstruction.DT, 55.6),
  ];
}
