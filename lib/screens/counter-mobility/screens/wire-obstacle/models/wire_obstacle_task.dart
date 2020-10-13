import 'package:flutter/foundation.dart';

class WireObstacleTask {
  int id;
  String task;
  int timesForday;
  int timesForNight;
  int nco;
  int men;
  String group;
  List<String> images;
  int barbedWire;
  int barbedWireConcertina;
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
    @required this.images,
    this.barbedWire,
    this.barbedWireConcertina,
    this.longPicket,
    this.shortPiquet,
    this.tracingTapRoll,
    this.mauls,
    this.wireCutter,
    this.windlassingStick,
  });
}

List<WireObstacleTask> listOfWireObstackleTasks = [
  WireObstacleTask(
    id: 1,
    task: "Double Apron Fence",
    timesForday: 100,
    timesForNight: 160,
    nco: 1,
    men: 10,
    group: "TF-A",
    images: ["assets/images/wire-obstacle/double_apron.png"],
    barbedWire: 13,
    longPicket: 40,
    shortPiquet: 82,
    wireCutter: 2,
    windlassingStick: 10,
    mauls: 5,
  ),
  WireObstacleTask(
    id: 2,
    task: "Catwire Fence (Type-3)",
    timesForday: 25,
    timesForNight: 75,
    nco: 1,
    men: 10,
    group: "TF-B",
    images: ["assets/images/wire-obstacle/catwire3.png"],
    barbedWireConcertina: 30,
    barbedWire: 12,
    longPicket: 128,
  ),
  WireObstacleTask(
    id: 3,
    task: "Standardize Triple Concertina Fence",
    timesForday: 100,
    timesForNight: 160,
    nco: 1,
    men: 7,
    group: "TF-3",
    images: [
      "assets/images/wire-obstacle/triple_conc1.png",
      "assets/images/wire-obstacle/triple_conc2.png"
    ],
    barbedWireConcertina: 18,
    barbedWire: 2,
    longPicket: 52,
    mauls: 3,
    wireCutter: 1,
    windlassingStick: 7,
  ),
  WireObstacleTask(
    id: 4,
    task: "High Wire Fence",
    timesForday: 160,
    timesForNight: 330,
    nco: 2,
    men: 14,
    group: "TF-D",
    images: [
      "assets/images/wire-obstacle/highwire1.png",
      "assets/images/wire-obstacle/highwire2.png"
    ],
    barbedWireConcertina: 32,
    barbedWire: 19,
    longPicket: 80,
    shortPiquet: 84,
    mauls: 7,
    wireCutter: 2,
    windlassingStick: 14,
  ),
  WireObstacleTask(
    id: 5,
    task: "Catwire Fence (Type-2)",
    timesForday: 40,
    timesForNight: 100,
    nco: 1,
    men: 10,
    group: "TF-B",
    images: ["assets/images/wire-obstacle/catwire2.png"],
    barbedWireConcertina: 24,
    barbedWire: 9,
    longPicket: 96,
    tracingTapRoll: 1,
    wireCutter: 1,
    windlassingStick: 1,
  ),
  WireObstacleTask(
    id: 6,
    task: "Catwire Fence (Type-1)",
    timesForday: 50,
    timesForNight: 120,
    nco: 1,
    men: 10,
    group: "TF-B",
    images: ["assets/images/wire-obstacle/catwire1.png"],
    barbedWireConcertina: 12,
    barbedWire: 6,
    longPicket: 16,
    tracingTapRoll: 1,
    wireCutter: 1,
    windlassingStick: 1,
  ),
];
