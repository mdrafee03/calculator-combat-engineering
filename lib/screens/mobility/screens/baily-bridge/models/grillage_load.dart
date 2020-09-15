class GrillageLoad {
  int pressureOfSoil;
  String type;
  double basePlate;
  double template;
  GrillageLoad(this.pressureOfSoil, this.type, this.basePlate, this.template);

  static List<GrillageLoad> grillageLoads = [
    new GrillageLoad(1, "Baseplate & Template Only", 13, 8),
    new GrillageLoad(1, "A", 15.5, 15.5),
    new GrillageLoad(1, "B", 25, 18),
    new GrillageLoad(1, "C", 33, 22.5),
    new GrillageLoad(1, "D", 41, 27),
    new GrillageLoad(1, "E", 46, 55),
    new GrillageLoad(1, "F", 69, 51),
    new GrillageLoad(2, "Baseplate & Template Only", 26, 16),
    new GrillageLoad(2, "A", 51, 27),
    new GrillageLoad(2, "B", 46, 33),
    new GrillageLoad(2, "C", 66, 45),
    new GrillageLoad(2, "D", 82, 54),
    new GrillageLoad(2, "E", 92, 70),
    new GrillageLoad(2, "F", 110, 88),
    new GrillageLoad(3, "Baseplate & Template Only", 39, 24),
    new GrillageLoad(3, "A", 46.5, 33),
    new GrillageLoad(3, "B", 64, 33),
    new GrillageLoad(3, "C", 75, 67),
    new GrillageLoad(3, "D", 100, 66),
    new GrillageLoad(3, "E", 110, 88),
    new GrillageLoad(3, "F", 110, 88),
  ];
}
