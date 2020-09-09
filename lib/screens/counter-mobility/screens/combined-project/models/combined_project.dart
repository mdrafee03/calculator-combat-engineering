import '../../../models/counter_mobility.dart';
import '../../../screens/reserve-demolition/models/reserve_demolition.dart';
import '../../minefield-laying/models/minefield_laying.dart';
import '../../wire-obstacle/models/wire_obstacle.dart';

class CombinedProject {
  List<MinefieldLaying> minefields = CounterMobility.listOfMinefieldLaying;
  List<ReserveDemolition> reserveDemolitions =
      CounterMobility.listOfReserveDemolition;
  List<WireObstacle> wireObstacles = CounterMobility.listOfWireObstacle;

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
    return reserveDemolitions.fold(0, (previousValue, element) {
          double abutment = element.listOfAbutment.fold(
              0,
              (previousValue, element) =>
                  previousValue +
                  element.totalChargeRequired(element.craterNo));
          double borehole = element.pier.boreholePier.totalChargeRequired;
          double pierFooting = element.pier.footingPier.totalAmountOfCharge;
          double roadway = element.listOfRoadway.fold(
              0,
              (previousValue, element) =>
                  previousValue + element.totalChargeRequired);
          double span = element.spanBeamGirder.totalChargeRequired;

          return previousValue +
              abutment +
              borehole +
              roadway +
              span +
              pierFooting;
        }) *
        1.1;
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
      return (element.spanBeamGirder.totalSandbagRequired * 1.1).ceil();
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
