class Roadway {
  double width;
  double length;
  final dia = 20;
  final depth = 7;
  final explosivePerCrater = 70;
  final craterIndividual = 10;
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

  int get totalCharge {
    return totalRoadCrater * explosivePerCrater;
  }

  int get totalTimeRequiredPerSection {
    return (totalRoadCrater * 2 / 3).ceil();
  }

  double get totalTimeRequired {
    return (totalTimeRequiredPerSection / 4);
  }
}
