class ReserveDemolitionSummary {
  static double abutmentCharge = 0;
  static double pierCharge = 0;
  static double spanCharge = 0;
  static double roadwayCharge = 0;

  static double abutmentTime = 0;
  static double pierTime = 0;
  static double spanTime = 0;
  static double roadwayTime = 0;
  static int sandbag = 0;

  double get totalExplosiveRequired {
    return abutmentCharge + pierCharge + spanCharge + roadwayCharge;
  }

  double get totalTimeRequired {
    return abutmentTime + pierTime + spanTime + roadwayTime;
  }

  int get getSandbag {
    return sandbag;
  }
}
