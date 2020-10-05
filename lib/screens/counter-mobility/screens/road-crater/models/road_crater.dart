class RoadCrater {
  double width;
  double length;
  final dia = 20;
  final depth = 7;
  final explosivePerCrater = 70;
  final lineOfGroupCrater = 80;

  int get totalRoadCraterAlongRoadWidh {
    return (width / dia).ceil();
  }

  int get totalLineOfGroupAlongRoadLength {
    return (length * 3.28084 / lineOfGroupCrater).ceil();
  }

  int get totalRoadCrater {
    return totalLineOfGroupAlongRoadLength * totalRoadCraterAlongRoadWidh;
  }

  double get totalChargeRequired {
    double charge = (totalRoadCrater * explosivePerCrater).toDouble();
    return charge;
  }

  int get totalTimeRequiredPerSection {
    return (totalRoadCrater * 2 / 3).ceil();
  }

  double get totalTimeRequired {
    double time = totalTimeRequiredPerSection / 4 >= 1
        ? totalTimeRequiredPerSection / 4
        : 1;
    return time;
  }
}
