import 'package:flutter/foundation.dart';

class WireObstacleTask {
  int id;
  String task;
  int timesForday;
  int timesForNight;
  int nco;
  int men;
  String group;
  int barbedWire;
  int barbedWireConcertina;
  int baredWireCoil;
  int concertinaCoil;
  int longPiquet;
  int longPicket;
  int shortPiquet;
  int tracingTapRoll;
  int mauls;
  int wireCutter;
  int windlassingStick;
  WireObstacleTask({
    @required this.id,
    @required this.task,
    @required this.timesForday,
    @required this.timesForNight,
    @required this.nco,
    @required this.men,
    @required this.group,
    this.barbedWire,
    this.barbedWireConcertina,
    this.baredWireCoil,
    this.concertinaCoil,
    this.longPiquet,
    this.longPicket,
    this.shortPiquet,
    this.tracingTapRoll,
    this.mauls,
    this.wireCutter,
    this.windlassingStick,
  });
}

List<WireObstacleTask> listOfWireObstackleTasks = [
  new WireObstacleTask(
    id: 1,
    task: "Double Apron Fence",
    timesForday: 100,
    timesForNight: 160,
    nco: 1,
    men: 10,
    group: "TF-A",
    barbedWire: 13,
    longPiquet: 40,
    shortPiquet: 82,
    wireCutter: 2,
    windlassingStick: 10,
    mauls: 5,
  ),
  new WireObstacleTask(
    id: 2,
    task: "Catwire Fence (Type-3)",
    timesForday: 25,
    timesForNight: 75,
    nco: 1,
    men: 10,
    group: "TF-B",
    barbedWireConcertina: 30,
    baredWireCoil: 12,
    longPiquet: 128,
  ),
  new WireObstacleTask(
    id: 3,
    task: "Standardize Triple Concertina Fence",
    timesForday: 100,
    timesForNight: 160,
    nco: 1,
    men: 7,
    group: "TF-3",
    barbedWireConcertina: 18,
    baredWireCoil: 2,
    longPiquet: 52,
    mauls: 3,
    wireCutter: 1,
    windlassingStick: 7,
  ),
  new WireObstacleTask(
    id: 4,
    task: "High Wire Fence",
    timesForday: 160,
    timesForNight: 330,
    nco: 2,
    men: 14,
    group: "TF-D",
    barbedWireConcertina: 32,
    baredWireCoil: 19,
    longPiquet: 80,
    shortPiquet: 84,
    mauls: 7,
    wireCutter: 2,
    windlassingStick: 14,
  ),
  new WireObstacleTask(
    id: 5,
    task: "Catwire Fence (Type-2)",
    timesForday: 40,
    timesForNight: 100,
    nco: 1,
    men: 10,
    group: "TF-B",
    concertinaCoil: 24,
    baredWireCoil: 9,
    longPicket: 96,
    tracingTapRoll: 1,
    wireCutter: 1,
    windlassingStick: 1,
  ),
  new WireObstacleTask(
    id: 6,
    task: "Catwire Fence (Type-1)",
    timesForday: 50,
    timesForNight: 120,
    nco: 1,
    men: 10,
    group: "TF-B",
    concertinaCoil: 12,
    baredWireCoil: 6,
    longPicket: 16,
    tracingTapRoll: 1,
    wireCutter: 1,
    windlassingStick: 1,
  ),
];
