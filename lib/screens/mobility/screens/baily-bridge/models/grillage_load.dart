class GrillageLoad {
  int pressureOfSoil;
  String type;
  double basePlate;
  double template;
  GrillageLoad(this.pressureOfSoil, this.type, this.basePlate, this.template);

  static List<GrillageLoad> grillageLoads = [
    GrillageLoad(1, "Baseplate & Template Only", 13, 8),
    GrillageLoad(1, "A", 15.5, 15.5),
    GrillageLoad(1, "B", 25, 18),
    GrillageLoad(1, "C", 33, 22.5),
    GrillageLoad(1, "D", 41, 27),
    GrillageLoad(1, "E", 46, 55),
    GrillageLoad(1, "F", 69, 51),
    GrillageLoad(2, "Baseplate & Template Only", 26, 16),
    GrillageLoad(2, "A", 51, 27),
    GrillageLoad(2, "B", 46, 33),
    GrillageLoad(2, "C", 66, 45),
    GrillageLoad(2, "D", 82, 54),
    GrillageLoad(2, "E", 92, 70),
    GrillageLoad(2, "F", 110, 88),
    GrillageLoad(3, "Baseplate & Template Only", 39, 24),
    GrillageLoad(3, "A", 46.5, 33),
    GrillageLoad(3, "B", 64, 33),
    GrillageLoad(3, "C", 75, 67),
    GrillageLoad(3, "D", 100, 66),
    GrillageLoad(3, "E", 110, 88),
    GrillageLoad(3, "F", 110, 88),
  ];
}
