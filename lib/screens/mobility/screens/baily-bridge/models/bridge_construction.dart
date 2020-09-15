class BridgeConstruction {
  int load;
  int ss;
  int ds;
  int dd;
  int dt;
  BridgeConstruction(this.load, this.ss, this.ds, this.dd, this.dt);
  static List<BridgeConstruction> bridgeConstructions = [
    new BridgeConstruction(9, 90, 150, 180, 230),
    new BridgeConstruction(12, 80, 140, 180, 220),
    new BridgeConstruction(18, 60, 110, 160, 200),
    new BridgeConstruction(24, 60, 110, 150, 200),
    new BridgeConstruction(30, 50, 100, 140, 190),
    new BridgeConstruction(40, 30, 80, 130, 180),
    new BridgeConstruction(50, 0, 60, 110, 160),
    new BridgeConstruction(60, 0, 50, 100, 130),
    new BridgeConstruction(70, 0, 40, 90, 120),
  ];
}
