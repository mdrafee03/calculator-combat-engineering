import 'dart:math';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:combat_engineering/shared/models/serial_manage.dart';
import 'package:combat_engineering/shared/widgets/section_sub_heading_pw.dart';
import 'package:combat_engineering/shared/widgets/top_header_pw.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' as m;

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
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
    if (minefields.length == 0) {
      return 12;
    }
    int time = minefields[0]?.timeRequired?.timeAvailableADay ?? 0;
    if (time != 0) {
      return time / 60;
    }
    return 12;
  }

  double dayTaken(double time) {
    return time / totalTimeADay;
  }

  String dateTableHeaderFormat(DateTime date) {
    return "${(date.day)}/${(date.day + 1)} ${(new DateFormat.MMM()).format(date)}";
  }

  String dateTableHeaderFormatPw(DateTime date) {
    return "${(date.day)}/${(date.day + 1)}-${(new DateFormat.MMM()).format(date)}";
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

  Future<void> generatePDF(Document doc) async {
    final slForParent = SerialManage();
    final format = PdfPageFormat.a4;
    int numberOfCol = TaskDistribution.taskDistributions.fold(
      0,
      (previousValue, element) => element.endDay > previousValue
          ? element.endDay.ceil()
          : previousValue,
    );
    Container buildTableHeader(String title) {
      return Container(
        height: 80,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(top: 5.0, bottom: 20),
        child: Transform.rotate(
          angle: pi / 2,
          child: Text(
            title,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Container buildTableCell(String cell, {bool isCenter = false}) {
      return Container(
        alignment: isCenter ? Alignment.center : Alignment.centerLeft,
        decoration: BoxDecoration(
          border: TableBorder(
            top: true,
          ),
        ),
        child: Text(cell),
      );
    }

    doc.addPage(
      MultiPage(
        pageFormat: format,
        build: (Context context) {
          return [
            TopHeaderPw("Combined Project"),
            if (minefields.length > 0)
              SectionHeadingPw(
                '${slForParent.serialNum} ',
                'Store Calculation for Minefield Laying',
              ),
            // minefield
            if (minefields.length > 0)
              for (int i = 0; i < minefields.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionSubHeadingPw(
                        "${String.fromCharCode(97 + i)}. ",
                        "Minefield Laying ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(i) Anti-Tank Mines = ${minefields[i].antiTankMines}",
                            ),
                            Text(
                              "(ii) Anti-Personnel Mines = ${minefields[i].antiPersonnelMines}",
                            ),
                            Text(
                              "(iii) Long Picket = ${minefields[i].longPicket}",
                            ),
                            Text(
                              "(iv) Short Picket = ${minefields[i].shortPicket}",
                            ),
                            Text(
                              "(v) Barbed Wire = ${minefields[i].barbedWire}",
                            ),
                            Text(
                              "(vi) Perimeter Post = ${minefields[i].perimeterSignPosting}",
                            ),
                            Text(
                              "(vii) Tracing Tape = ${minefields[i].tracingTape}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
            if (minefields.length > 0)
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Stores for all Minefield Laying",
                      style: TextStyle(
                        color: PDFTheme.color,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Anti-Tank Mines = ${minefields.fold(0, (previousValue, element) => previousValue + element.antiTankMines)}",
                          ),
                          Text(
                              "(ii) Anti-Personnel Mines = ${minefields.fold(0, (previousValue, element) => previousValue + element.antiPersonnelMines)}"),
                          Text(
                              "(iii) Long Picket = ${minefields.fold(0, (previousValue, element) => previousValue + element.longPicket)}"),
                          Text(
                              "(iv) Short Picket = ${minefields.fold(0, (previousValue, element) => previousValue + element.shortPicket)}"),
                          Text(
                              "(v) Barbed Wire = ${minefields.fold(0, (previousValue, element) => previousValue + element.barbedWire)}"),
                          Text(
                              "(vi) Perimeter Post = ${minefields.fold(0, (previousValue, element) => previousValue + element.perimeterSignPosting)}"),
                          Text(
                              "(vii) Tracing Tape = ${minefields.fold(0, (previousValue, element) => previousValue + element.tracingTape)}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            // reserve Demolition
            if (reserveDemolitions.length > 0)
              SectionHeadingPw(
                '${slForParent.serialNum}. ',
                'Store Calculation for Reserve Demoltion',
              ),
            if (reserveDemolitions.length > 0)
              for (int i = 0; i < reserveDemolitions.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionSubHeadingPw(
                        "${String.fromCharCode(97 + i)}. ",
                        "Reserve Demolition ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(i) Plastic Explosive = ${reserveDemolitions[i].plasticExplosive.toStringAsFixed(2)}",
                            ),
                            Text(
                              "(ii) Hayrick = ${reserveDemolitions[i]?.pier?.shapedCharge?.totalNoOfHyrics ?? 0}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
            if (reserveDemolitions.length > 0)
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Stores for all Reserve Demolition",
                      style: TextStyle(
                        color: PDFTheme.color,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Plastic Explosive = ${reserveDemolitions.fold<double>(0, (previousValue, element) => previousValue + element.plasticExplosive).toStringAsFixed(2)}",
                          ),
                          Text(
                            "(ii) Hayrick = ${reserveDemolitions?.fold(0, (previousValue, element) => previousValue + element.hayrics) ?? 0}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            // wire obstacle
            if (wireObstacles.length > 0)
              SectionHeadingPw(
                '${slForParent.serialNum}. ',
                'Store Calculation for Wire Obstacle',
              ),
            if (wireObstacles.length > 0)
              for (int i = 0; i < wireObstacles.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionSubHeadingPw(
                        "${String.fromCharCode(97 + i)}. ",
                        "Wire Obstacle ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (wireObstacles[i].task.barbedWire != null)
                              Text(
                                "(i) Barbed Wire = ${wireObstacles[i].getValueByFrontage(wireObstacles[i].task.barbedWire)}",
                              ),
                            if (wireObstacles[i].task.barbedWireConcertina !=
                                null)
                              Text(
                                  "(ii) barbed Wire Concertina = ${wireObstacles[i].getValueByFrontage(wireObstacles[i].task.barbedWireConcertina)}"),
                            Text(
                              "(iii) Long Picket = ${wireObstacles[i].getValueByFrontage(wireObstacles[i].task.longPicket)}",
                            ),
                            if (wireObstacles[i].task.shortPiquet != null)
                              Text(
                                "(iv) Short Picket = ${wireObstacles[i].getValueByFrontage(wireObstacles[i].task.shortPiquet)}",
                              ),
                            if (wireObstacles[i].task.mauls != null)
                              Text(
                                "(v) Sledge Hammer = ${wireObstacles[i].getValueBySection(wireObstacles[i].task.mauls)}",
                              ),
                            if (wireObstacles[i].task.tracingTapRoll != null)
                              Text(
                                "(vi) Tracing Tape Roll = ${wireObstacles[i].getValueBySection(wireObstacles[i].task.tracingTapRoll)}",
                              ),
                            if (wireObstacles[i].task.wireCutter != null)
                              Text(
                                "(vii) Wire Cutter = ${wireObstacles[i].getValueBySection(wireObstacles[i].task.wireCutter)}",
                              ),
                            if (wireObstacles[i].task.windlassingStick != null)
                              Text(
                                "(viii) Windlassing Sticks = ${wireObstacles[i].getValueBySection(wireObstacles[i].task.windlassingStick)}",
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
            if (wireObstacles.length > 0)
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Stores for all Wire Obstacle",
                      style: TextStyle(
                        color: PDFTheme.color,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Barbed Wire= ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWire ?? 0))}",
                          ),
                          Text(
                            "(ii) Barbed Wire Concertina = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.barbedWireConcertina ?? 0))}",
                          ),
                          Text(
                            "(iii) Long Picket = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.longPicket ?? 0))}",
                          ),
                          Text(
                            "(iv) Short Picket = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueByFrontage(element.task.shortPiquet ?? 0))}",
                          ),
                          Text(
                            "(v) Sledge Hammer = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.mauls ?? 0))}",
                          ),
                          Text(
                            "(vi) Tracing Tape Roll = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.tracingTapRoll ?? 0))}",
                          ),
                          Text(
                            "(vii) Wire Cutter = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.wireCutter ?? 0))}",
                          ),
                          Text(
                            "(viii) Windlassing Sticks = ${wireObstacles.fold(0, (previousValue, element) => previousValue + element.getValueBySection(element.task.windlassingStick ?? 0))}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            // Store List Combined
            SectionHeadingPw(
              '${slForParent.serialNum}. ',
              'Store List for Combined Engineer Project',
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Anti Tank Mines = $antiTankMines",
                        ),
                        Text(
                          "b. Anti Personnel Mines = $antiPersonnelMines",
                        ),
                        Text(
                          "c. Long Picket = $longPickets",
                        ),
                        Text(
                          "d. Short Picket = $shortPickets",
                        ),
                        Text(
                          "e. Barbed Wire Coil = $barbedWireCoil",
                        ),
                        Text(
                          "f. Perimeter Sign Posting = $perimeterPosting",
                        ),
                        Text(
                          "g. Tracing Tape = $tracingTape",
                        ),
                        Text(
                          "h. Plastic Explosive = ${plasticExplosive.toStringAsFixed(2)}",
                        ),
                        Text(
                          "j. Sledge hammer = $sledgeHammer",
                        ),
                        Text(
                          "k. Wire Cutter = $wireCutter",
                        ),
                        Text(
                          "l. Sand Bag = $sandbag",
                        ),
                        Text(
                          "m. Windlassing Stick = $windlassingStick",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            SectionHeadingPw('${slForParent.serialNum}. ', 'Work Program'),
            Table(
              border: TableBorder(horizontalInside: false),
              columnWidths: {
                0: FixedColumnWidth(20),
                1: FixedColumnWidth(140),
                2: FixedColumnWidth(20),
                3: FixedColumnWidth(20),
                4: FixedColumnWidth(50),
                for (int i = 0; i < numberOfCol; i++)
                  i + 5: FixedColumnWidth(20),
              },
              children: [
                TableRow(
                  children: [
                    buildTableHeader('Ser'),
                    buildTableHeader('Task'),
                    buildTableHeader('Task-Force'),
                    buildTableHeader('Pri'),
                    buildTableHeader('Pl Hr'),
                    for (int i = 0; i < numberOfCol; i++)
                      buildTableHeader((dateTableHeaderFormatPw(
                          startDate.add(Duration(days: i))))),
                  ],
                ),
                for (int i = 0;
                    i < TaskDistribution.taskDistributions.length;
                    i++)
                  TableRow(
                    decoration:
                        TaskDistribution.taskDistributions[i].startForce &&
                                i != 0
                            ? BoxDecoration(
                                border: BoxBorder(top: true, width: 2),
                              )
                            : null,
                    children: [
                      buildTableCell((i + 1).toString(), isCenter: true),
                      buildTableCell(
                        TaskDistribution.taskDistributions[i].name,
                      ),
                      Container(
                        decoration: i == 0
                            ? BoxDecoration(border: BoxBorder(top: true))
                            : null,
                        alignment: Alignment.center,
                        child: Text(TaskDistribution
                                .taskDistributions[i].startForce
                            ? TaskDistribution.taskDistributions[i].force.name
                            : ''),
                      ),
                      buildTableCell(
                          TaskDistribution.taskDistributions[i].priority
                              .toString(),
                          isCenter: true),
                      buildTableCell(
                        TaskDistribution.taskDistributions[i].time
                            .toStringAsFixed(2),
                      ),
                      ...List.generate(numberOfCol, (index) {
                        Widget temp;
                        if ((index >=
                                TaskDistribution.taskDistributions[i].startDay
                                    .floor() &&
                            index <=
                                TaskDistribution.taskDistributions[i].endDay)) {
                          double startDay =
                              TaskDistribution.taskDistributions[i].startDay;
                          double endDay =
                              TaskDistribution.taskDistributions[i].endDay;
                          if (startDay - index < 1 &&
                              startDay - index >= 0 &&
                              endDay - index < 1 &&
                              endDay - index >= 0) {
                            temp = Container(
                              margin: EdgeInsets.only(
                                  left: 20 * (startDay - index),
                                  right: 20 * (1 - (endDay - index))),
                              color: TaskDistribution
                                  .taskDistributions[i].force.pdfColor,
                            );
                          } else if (startDay - index < 1 &&
                              startDay - index >= 0) {
                            temp = Container(
                              margin: EdgeInsets.only(
                                  left: 20 * (startDay - index)),
                              color: TaskDistribution
                                  .taskDistributions[i].force.pdfColor,
                            );
                          } else if (endDay - index < 1 &&
                              endDay - index >= 0) {
                            temp = Container(
                              margin: EdgeInsets.only(
                                  right: 20 * (1 - (endDay - index))),
                              color: TaskDistribution
                                  .taskDistributions[i].force.pdfColor,
                            );
                          } else {
                            temp = Container(
                              color: TaskDistribution
                                  .taskDistributions[i].force.pdfColor,
                            );
                          }
                        } else {
                          temp = Text("");
                        }
                        return Container(
                            decoration: BoxDecoration(
                              border: BoxBorder(top: true),
                            ),
                            height: 13,
                            child: temp);
                      }),
                    ],
                  ),
              ],
            ),
          ];
        },
      ),
    );
  }

  void savePDF(m.BuildContext ctx) async {
    var doc = Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File("$directory/Combined-Project-Engineering.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
      bytes: doc.save(),
      filename: 'Combined-Project-Engineering.pdf',
    );
  }
}
