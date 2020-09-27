import 'package:flutter/material.dart';

class BreachingLane {
  int serial;
  String party;
  String task;
  int time;
  TimeOfDay from;
  TimeOfDay to;
  bool startParty;
  BreachingLane({
    this.serial,
    this.party,
    this.task,
    this.time,
    this.from,
    this.to,
    this.startParty,
  });
}

class BreachingLaneList {
  List<BreachingLane> branchingLane;
  int type;
  int depth;
  BreachingLaneList({
    this.branchingLane,
    this.type,
    this.depth,
  });
}
