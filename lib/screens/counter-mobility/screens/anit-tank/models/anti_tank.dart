class AntiTank {
  double length;

  final double width = 4.83;
  final double height = 5 / 3;

  double get volume {
    return length * height * width;
  }

  double get timeRequiredPerDozon {
    return volume / 55;
  }

  double get totalTimeRequired {
    double time = timeRequiredPerDozon / 4;
    return time <= 1 ? 1 : time;
  }
}
