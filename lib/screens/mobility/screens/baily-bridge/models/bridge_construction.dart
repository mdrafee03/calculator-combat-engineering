class BridgeConstruction {
  int load;
  int ss;
  int ds;
  int dd;
  int dt;
  BridgeConstruction(this.load, this.ss, this.ds, this.dd, this.dt);
  static List<BridgeConstruction> bridgeConstructions = [
    BridgeConstruction(9, 90, 150, 180, 230),
    BridgeConstruction(12, 80, 140, 180, 220),
    BridgeConstruction(18, 60, 110, 160, 200),
    BridgeConstruction(24, 60, 110, 150, 200),
    BridgeConstruction(30, 50, 100, 140, 190),
    BridgeConstruction(40, 30, 80, 130, 180),
    BridgeConstruction(50, 0, 60, 110, 160),
    BridgeConstruction(60, 0, 50, 100, 130),
    BridgeConstruction(70, 0, 40, 90, 120),
  ];
}
