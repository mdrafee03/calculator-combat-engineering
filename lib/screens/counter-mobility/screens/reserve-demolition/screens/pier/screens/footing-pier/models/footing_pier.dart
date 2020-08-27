class FootingPier {
  double width;
  double thickness;

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
}
