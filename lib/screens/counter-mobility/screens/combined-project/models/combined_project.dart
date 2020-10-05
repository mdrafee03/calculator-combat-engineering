import 'package:intl/intl.dart';

import '../../../models/counter_mobility.dart';
import '../../minefield-laying/models/minefield_laying.dart';
import '../../reserve-demolition/models/reserve_demolition.dart';
import '../../wire-obstacle/models/wire_obstacle.dart';
import '../../road-crater/models/road_crater.dart';
import '../../anit-tank/models/anti_tank.dart';
import './taskforce.dart';
import './task_distribution.dart';

class CombinedProject {
  List<MinefieldLaying> minefields = CounterMobility.listOfMinefieldLaying;
  List<ReserveDemolition> reserveDemolitions =
      CounterMobility.listOfReserveDemolition;
  List<WireObstacle> wireObstacles = CounterMobility.listOfWireObstacle;
  List<RoadCrater> roadcraters = CounterMobility.listOfRoadCrater;
  List<AntiTank> antiTanks = CounterMobility.listOfAntiTank;

  DateTime startDate = DateTime.now();

  int get totalCount {
    return minefields.length +
        reserveDemolitions.length +
        wireObstacles.length +
        roadcraters.length +
        antiTanks.length;
  }

  double get totalTimeADay {
    int time = minefields[0]?.timeRequired?.timeAvailableADay ?? 0;
    if (time != 0) {
      return time / 60;
    } else {
      return 12;
    }
  }

  double dayTaken(double time) {
    return time / totalTimeADay;
  }

  String dateTableHeaderFormat(DateTime date) {
    return "${(date.day)}/${(date.day + 1)} ${(new DateFormat.MMM()).format(date)}";
  }

  void taskDistributionCalculation() {
    TaskDistribution.taskDistributions = [];
    List<int> minefieldByForces = [0, 0, 0];
    if (minefields.length > 0) {
      int minefieldPerForce = (minefields.length / 3).ceil();
      if (minefields.length <= 1) {
        minefieldByForces[0] = minefieldPerForce;
      } else {
        minefieldByForces[0] = minefieldPerForce;
        minefieldByForces[1] =
            ((minefields.length - minefieldPerForce) / 2).ceil();
        minefieldByForces[2] =
            minefields.length - minefieldByForces[0] - minefieldByForces[1];
      }
    }

    List<int> reserveDemolitionByForces = [0, 0, 0];
    if (reserveDemolitions.length > 0) {
      int reserveDemolitionPerForce = (reserveDemolitions.length / 3).ceil();
      if (reserveDemolitions.length <= 1) {
        reserveDemolitionByForces[1] = reserveDemolitionPerForce;
      } else {
        reserveDemolitionByForces[2] = reserveDemolitionPerForce;
        reserveDemolitionByForces[0] =
            ((reserveDemolitions.length - reserveDemolitionPerForce) / 2)
                .ceil();
        reserveDemolitionByForces[1] = reserveDemolitions.length -
            reserveDemolitionByForces[2] -
            reserveDemolitionByForces[0];
      }
    }

    List<int> wireObstacleByForces = [0, 0, 0];
    if (wireObstacles.length > 0) {
      int wireObstaclePerForce = (wireObstacles.length / 3).ceil();
      if (wireObstacles.length <= 1) {
        wireObstacleByForces[2] = wireObstaclePerForce;
      } else {
        wireObstacleByForces[1] = wireObstaclePerForce;
        wireObstacleByForces[2] =
            ((wireObstacles.length - wireObstaclePerForce) / 2).ceil();
        wireObstacleByForces[0] = wireObstacles.length -
            wireObstacleByForces[1] -
            wireObstacleByForces[2];
      }
    }

    List<int> roadCraterByForces = [0, 0, 0];
    if (roadcraters.length > 0) {
      int roadCraterPerForce = (roadcraters.length / 3).ceil();
      if (roadcraters.length <= 1) {
        roadCraterByForces[0] = roadCraterPerForce;
      } else {
        roadCraterByForces[1] = roadCraterPerForce;
        roadCraterByForces[2] =
            ((roadcraters.length - roadCraterPerForce) / 2).ceil();
        roadCraterByForces[0] =
            roadcraters.length - roadCraterByForces[1] - roadCraterByForces[2];
      }
    }

    List<int> antiTankByForces = [0, 0, 0];
    if (antiTanks.length > 0) {
      int antiTankPerForce = (antiTanks.length / 3).ceil();
      if (antiTanks.length <= 1) {
        antiTankByForces[1] = antiTankPerForce;
      } else {
        antiTankByForces[0] = antiTankPerForce;
        antiTankByForces[1] =
            ((antiTanks.length - antiTankPerForce) / 2).ceil();
        antiTankByForces[2] =
            antiTanks.length - antiTankByForces[0] - antiTankByForces[1];
      }
    }

    int minefieldCounter = 0;
    int reserveDemolitionCounter = 0;
    int wireObstacleCounter = 0;
    int roadCraterCounter = 0;
    int antiTankCounter = 0;
    for (int i = 0; i < 3; i++) {
      bool start = true;
      int priority = 1;
      double startDay = 0;
      for (int j = 0; j < minefieldByForces[i]; j++) {
        double time =
            minefields[minefieldCounter].timeRequired.totalTimeRequired;
        double endDay = startDay + dayTaken(time);
        TaskDistribution.taskDistributions.add(
          new TaskDistribution(
            name: "Minefield ${minefieldCounter + 1}",
            time: time,
            force: Taskforce.taskforces[i],
            priority: priority,
            startDay: startDay,
            endDay: endDay,
            startForce: start,
          ),
        );
        start = false;
        startDay = endDay;
        minefieldCounter += 1;
        priority += 1;
      }
      for (int j = 0; j < reserveDemolitionByForces[i]; j++) {
        double time =
            reserveDemolitions[reserveDemolitionCounter].totalTimeRequired;
        double endDay = startDay + dayTaken(time);
        TaskDistribution.taskDistributions.add(
          new TaskDistribution(
            name: "Reserve Demolition ${reserveDemolitionCounter + 1}",
            time: time,
            force: Taskforce.taskforces[i],
            priority: priority,
            startDay: startDay,
            endDay: endDay,
            startForce: start,
          ),
        );
        start = false;
        startDay = endDay;
        reserveDemolitionCounter += 1;
        priority += 1;
      }
      for (int j = 0; j < wireObstacleByForces[i]; j++) {
        double time = wireObstacles[wireObstacleCounter].totalTimeRequire;
        double endDay = startDay + dayTaken(time);
        TaskDistribution.taskDistributions.add(
          new TaskDistribution(
            name: "Wire Obstacle ${wireObstacleCounter + 1}",
            time: time,
            force: Taskforce.taskforces[i],
            priority: priority,
            startDay: startDay,
            endDay: endDay,
            startForce: start,
          ),
        );
        start = false;
        startDay = endDay;
        wireObstacleCounter += 1;
        priority += 1;
      }
      for (int j = 0; j < roadCraterByForces[i]; j++) {
        double time = roadcraters[roadCraterCounter].totalTimeRequired;
        double endDay = startDay + dayTaken(time);
        TaskDistribution.taskDistributions.add(
          new TaskDistribution(
            name: "Road Crater ${roadCraterCounter + 1}",
            time: time,
            force: Taskforce.taskforces[i],
            priority: priority,
            startDay: startDay,
            endDay: endDay,
            startForce: start,
          ),
        );
        start = false;
        startDay = endDay;
        roadCraterCounter += 1;
        priority += 1;
      }
      for (int j = 0; j < antiTankByForces[i]; j++) {
        double time = antiTanks[antiTankCounter].totalTimeRequired;
        double endDay = startDay + dayTaken(time);
        TaskDistribution.taskDistributions.add(
          new TaskDistribution(
            name: "Anti Tank ${antiTankCounter + 1}",
            time: time,
            force: Taskforce.taskforces[i],
            priority: priority,
            startDay: startDay,
            endDay: endDay,
            startForce: start,
          ),
        );
        start = false;
        startDay = endDay;
        antiTankCounter += 1;
        priority += 1;
      }
    }
    List<int> priorityIndexes = [];
    TaskDistribution.taskDistributions.asMap().forEach((i, element) {
      if (element.priority == 1) priorityIndexes.add(i);
    });
  }

  int get antiTankMines {
    double mines = ((minefields.fold(
            0,
            (previousValue, element) =>
                previousValue + element.antiTankMines)) *
        1.1);
    return mines.ceil();
  }

  int get antiPersonnelMines {
    double mines = ((minefields.fold(
            0,
            (previousValue, element) =>
                previousValue + element.antiPersonnelMines)) *
        1.1);
    return mines.ceil();
  }

  int get longPickets {
    double longPicketMinefield = minefields.fold(
        0, (previousValue, element) => previousValue + element.longPicket);
    double longPicketWireObstacle = wireObstacles.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.getValueByFrontage(element.task.longPicket));
    return ((longPicketMinefield + longPicketWireObstacle) * 1.1).ceil();
  }

  int get shortPickets {
    double shortPicketMinefield = minefields.fold(
        0, (previousValue, element) => previousValue + element.shortPicket);
    double shortPicketWireObstacle = wireObstacles.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.getValueByFrontage(element.task.shortPiquet ?? 0));
    return ((shortPicketMinefield + shortPicketWireObstacle) * 1.1).ceil();
  }

  int get barbedWireCoil {
    double barbedWireMinefield = minefields.fold(
        0, (previousValue, element) => previousValue + element.barbedWire);
    double barbedWireWireObstacle = wireObstacles.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.getValueByFrontage(element.task.barbedWire ?? 0));
    return ((barbedWireMinefield + barbedWireWireObstacle) * 1.1).ceil();
  }

  int get perimeterPosting {
    double perimeterMinefield = minefields.fold(
        0,
        (previousValue, element) =>
            previousValue + element.perimeterSignPosting);
    return (perimeterMinefield * 1.1).ceil();
  }

  int get tracingTape {
    double tracingTapeMinefield = minefields.fold(
        0, (previousValue, element) => previousValue + element.tracingTape);
    double tracingTapeWireObstacle = wireObstacles.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.getValueByFrontage(element.task.tracingTapRoll ?? 0));
    return ((tracingTapeMinefield + tracingTapeWireObstacle) * 1.1).ceil();
  }

  double get plasticExplosive {
    return reserveDemolitions.fold(0,
        (previousValue, element) => previousValue + element.plasticExplosive);
  }

  int get sledgeHammer {
    return (wireObstacles.fold<double>(
                0,
                (previousValue, element) =>
                    previousValue +
                    element.getValueBySection(element.task.mauls ?? 0)) *
            1.1)
        .ceil();
  }

  int get wireCutter {
    return (wireObstacles.fold<double>(
                0,
                (previousValue, element) =>
                    previousValue +
                    element.getValueBySection(element.task.wireCutter ?? 0)) *
            1.1)
        .ceil();
  }

  int get sandbag {
    return reserveDemolitions.fold(0, (previousValue, element) {
      return (element?.spanBeamGirder?.totalSandbagRequired ?? 0 * 1.1).ceil();
    });
  }

  int get windlassingStick {
    return wireObstacles.fold(0, (previousValue, element) {
      return (element.getValueBySection(element.task.windlassingStick ?? 0) *
              1.1)
          .ceil();
    });
  }
}
