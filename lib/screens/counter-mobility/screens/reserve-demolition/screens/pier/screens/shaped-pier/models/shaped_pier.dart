class ShapedPier {
  double dia;
  int noOfPier;

  double get circumferencePerPier {
    return 3.14 * dia;
  }

  int get noOfHyricks {
    return (circumferencePerPier * 12 / 6).ceil();
  }

  int get totalNoOfHyrics {
    return noOfHyricks * noOfPier;
  }

  int get totalTimeRequiredPerSection {
    return (noOfPier * 4).ceil();
  }

  double get totalTimeRequired {
    return (totalTimeRequiredPerSection / 4);
  }
}
