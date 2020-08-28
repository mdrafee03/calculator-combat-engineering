class FootingPier {
  double width;
  double thickness;
  int noOfPier;

  double get explosivePerCharge {
    int factor = thickness <= 6 ? 10 : 20;
    return factor * thickness;
  }

  int get totalNoOfCharge {
    return (width / thickness).ceil();
  }

  double get totalAmountCharge {
    return explosivePerCharge * totalNoOfCharge;
  }

  double get outerCharges {
    return thickness / 2 * 12;
  }

  double get innerCharges {
    return thickness * 12;
  }

  int get totalTimeRequired {
    int timePerSection = width <= 20 ? 2 : 3;
    return (noOfPier * timePerSection / 4).ceil();
  }
}
