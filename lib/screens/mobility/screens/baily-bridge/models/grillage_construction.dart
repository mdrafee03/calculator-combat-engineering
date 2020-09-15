import './baily_bridge.dart';

class GrillageConstruction {
  int span;
  TypesOfConstruction type;
  double maxBaseplate;
  GrillageConstruction(this.span, this.type, this.maxBaseplate);

  static List<GrillageConstruction> grillageConstructions = [
    new GrillageConstruction(30, TypesOfConstruction.SS, 20.8),
    new GrillageConstruction(40, TypesOfConstruction.SS, 21.8),
    new GrillageConstruction(40, TypesOfConstruction.DS, 22.2),
    new GrillageConstruction(50, TypesOfConstruction.DS, 23.3),
    new GrillageConstruction(60, TypesOfConstruction.DS, 24.2),
    new GrillageConstruction(70, TypesOfConstruction.DS, 25.1),
    new GrillageConstruction(80, TypesOfConstruction.DS, 25.9),
    new GrillageConstruction(90, TypesOfConstruction.DD, 30.7),
    new GrillageConstruction(100, TypesOfConstruction.DD, 32.9),
    new GrillageConstruction(110, TypesOfConstruction.DD, 35.3),
    new GrillageConstruction(120, TypesOfConstruction.DD, 37.6),
    new GrillageConstruction(130, TypesOfConstruction.DD, 39.9),
    new GrillageConstruction(140, TypesOfConstruction.DT, 47.5),
    new GrillageConstruction(150, TypesOfConstruction.DT, 49.4),
    new GrillageConstruction(160, TypesOfConstruction.DT, 51.2),
    new GrillageConstruction(170, TypesOfConstruction.DT, 53.1),
    new GrillageConstruction(180, TypesOfConstruction.DT, 55.6),
  ];
}
