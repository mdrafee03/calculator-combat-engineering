import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import "../../../../../shared/extension-methods/timeOfDay_apis.dart";
import '../models/breaching_lane.dart';

class MinefieldBreaching {
  Fraction density;
  int noOfFieldEngineerPlatoon;
  int noOfInfantryPlatoon;
  int noOfAssaultPioneerPlatoon;
  TimeOfDay firstLight = TimeOfDay.now();
  TimeOfDay lastLight = TimeOfDay.now();
  TimeOfDay startTime = TimeOfDay.now();
  int branchingLaneDepth;
  int restTime;
  TimeOfDay completionTime;
  int completionDay;

  List<BreachingLaneList> get timeCalculation {
    List<BreachingLaneList> breachingLaneList =
        determineSteps(branchingLaneDepth);
    int day = 0;
    TimeOfDay currentTime = startTime;

    List<BreachingLane> createBreachingLane(
      int type,
      TimeOfDay start,
      bool first,
      bool last,
    ) {
      TimeOfDay current = start;
      List<BreachingLane> breachingLanes = [];
      TimeOfDay addedTime;
      bool isDayIncrease = false;
      void checkIfDayEnd(int duration) {
        addedTime = current.addMinutes(duration);
        if (addedTime.hour < 12 && addedTime > firstLight) {
          isDayIncrease = true;
          int remaining = duration - (firstLight - current);
          addedTime = lastLight.addMinutes(remaining);
        }
      }

      // Setting out party
      if (!first) {
        checkIfDayEnd(restTime);
        breachingLanes.add(BreachingLane(
          serial: 1,
          party: "Setting Out Party",
          task: "Rest",
          time: restTime,
          from: current,
          to: addedTime,
          startParty: true,
        ));
        current = addedTime;
      }
      checkIfDayEnd(10);
      breachingLanes.add(BreachingLane(
        serial: 1,
        party: "Setting Out Party",
        task: "Laying Base Tape",
        time: 10,
        from: current,
        to: addedTime,
        startParty: first ? true : false,
      ));
      current = addedTime;

      int guideTapeTime =
          type >= 60 ? calculateGuideTape(60) : calculateGuideTape(type);
      checkIfDayEnd(guideTapeTime);
      breachingLanes.add(BreachingLane(
        serial: 1,
        party: "Setting Out Party",
        task: "Laying Guide Tape",
        time: guideTapeTime,
        from: current,
        to: addedTime,
        startParty: false,
      ));
      current = addedTime;

      checkIfDayEnd(10);
      breachingLanes.add(BreachingLane(
        serial: 1,
        party: "Setting Out Party",
        task: "Laying Cross Tape",
        time: 10,
        from: current,
        to: addedTime,
        startParty: false,
      ));
      current = addedTime;
      if (type == 120) {
        checkIfDayEnd(guideTapeTime);
        breachingLanes.add(BreachingLane(
          serial: 1,
          party: "Setting Out Party",
          task: "Laying Guide Tape to Far Edge",
          time: guideTapeTime,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;

        checkIfDayEnd(10);
        breachingLanes.add(BreachingLane(
          serial: 1,
          party: "Setting Out Party",
          task: "Laying Finishing Tape",
          time: 10,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;
      }

      // Basic Breaching Party-1
      current = start;
      checkIfDayEnd(25);
      current = addedTime;

      int timeForFirstProding = type >= 60 ? 60 : type;
      checkIfDayEnd(timeForFirstProding);
      breachingLanes.add(BreachingLane(
        serial: 2,
        party: "Basic Breaching Party-1",
        task: "Prodding 1st Segment",
        time: timeForFirstProding,
        from: current,
        to: addedTime,
        startParty: true,
      ));
      current = addedTime;

      if (type == 120) {
        checkIfDayEnd(60);
        breachingLanes.add(BreachingLane(
          serial: 2,
          party: "Basic Breaching Party-1",
          task: "Prodding 2nd Segment",
          time: 60,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;
      }
      // Basic Breaching Party-2
      current = start;
      checkIfDayEnd(45);
      current = addedTime;

      checkIfDayEnd(timeForFirstProding);
      breachingLanes.add(BreachingLane(
        serial: 3,
        party: "Basic Breaching Party-2",
        task: "Prodding 1st Segment",
        time: timeForFirstProding,
        from: current,
        to: addedTime,
        startParty: true,
      ));
      current = addedTime;

      if (type == 120) {
        checkIfDayEnd(60);
        breachingLanes.add(BreachingLane(
          serial: 3,
          party: "Basic Breaching Party-2",
          task: "Prodding 2nd Segment",
          time: 60,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;
      }

      // Basic Breaching Party-3

      current = start;
      checkIfDayEnd(65);
      current = addedTime;

      checkIfDayEnd(timeForFirstProding);
      breachingLanes.add(BreachingLane(
        serial: 4,
        party: "Basic Breaching Party-3",
        task: "Prodding 1st Segment",
        time: timeForFirstProding,
        from: current,
        to: addedTime,
        startParty: true,
      ));
      current = addedTime;

      if (type == 120) {
        checkIfDayEnd(60);
        breachingLanes.add(BreachingLane(
          serial: 4,
          party: "Basic Breaching Party-3",
          task: "Prodding 2nd Segment",
          time: 60,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;
      }

      // Basic Breaching Party-4

      current = start;
      checkIfDayEnd(85);
      current = addedTime;

      checkIfDayEnd(timeForFirstProding);
      breachingLanes.add(BreachingLane(
        serial: 5,
        party: "Basic Breaching Party-4",
        task: "Prodding 1st Segment",
        time: timeForFirstProding,
        from: current,
        to: addedTime,
        startParty: true,
      ));
      current = addedTime;

      if (type == 120) {
        checkIfDayEnd(60);
        breachingLanes.add(BreachingLane(
          serial: 5,
          party: "Basic Breaching Party-4",
          task: "Prodding 2nd Segment",
          time: 60,
          from: current,
          to: addedTime,
          startParty: false,
        ));
        current = addedTime;
      }

      if (last) {
        checkIfDayEnd(pullingParty);
        breachingLanes.add(BreachingLane(
          serial: 6,
          party: "Pulling Party",
          task: "Pulling At Mine",
          time: pullingParty,
          from: current,
          to: addedTime,
          startParty: true,
        ));
        current = addedTime;

        checkIfDayEnd(markingLane);
        breachingLanes.add(BreachingLane(
          serial: 7,
          party: "Setting Out and Basic Breaching Parties",
          task: "Marking the lanes",
          time: markingLane,
          from: current,
          to: addedTime,
          startParty: true,
        ));
        current = addedTime;
      }
      currentTime = current;
      day = isDayIncrease ? day + 1 : day;
      return breachingLanes;
    }

    int incrementalDepth = 0;
    for (int i = 0; i < breachingLaneList.length; i++) {
      breachingLaneList[i].branchingLane = createBreachingLane(
        breachingLaneList[i].type,
        currentTime,
        i == 0,
        i == breachingLaneList.length - 1,
      );
      incrementalDepth += breachingLaneList[i].type;
      breachingLaneList[i].depth = incrementalDepth;
    }
    completionDay = day;
    completionTime = currentTime;
    return breachingLaneList;
  }

  int get pullingParty {
    int mines = (8 * density.toDouble()).ceil();
    return (mines * 5 / 3).ceil();
  }

  int get markingLane {
    double platoon = noOfFieldEngineerPlatoon +
        0.5 * noOfAssaultPioneerPlatoon +
        0.5 * noOfInfantryPlatoon;
    return (30 * branchingLaneDepth / 120 / platoon).ceil();
  }

  List<BreachingLaneList> determineSteps(int depth) {
    List<BreachingLaneList> steps = [];
    int remaining = depth;
    if (remaining >= 120) {
      int dividend = remaining ~/ 120;
      for (int i = 0; i < dividend; i++)
        steps.add(BreachingLaneList(type: 120));
      remaining = remaining % 120;
    }
    if (remaining >= 60) {
      steps.add(BreachingLaneList(type: 60));
      remaining -= 60;
    }
    if (remaining > 0) {
      steps.add(BreachingLaneList(type: remaining));
    }
    return steps;
  }

  int calculateGuideTape(depth) {
    return (60 * depth / 90).ceil();
  }

  int get longPicket {
    return (((2 * branchingLaneDepth / 12.5) + 2) * 1.1).ceil();
  }

  int get barbedWire {
    return (4 * branchingLaneDepth / 100).ceil();
  }

  int get safeLaneMarker {
    return (2 * branchingLaneDepth / 100).ceil();
  }

  int get greenYellowLight {
    return (safeLaneMarker * 1.2).ceil();
  }

  int get tape {
    return ((4 * branchingLaneDepth * 1.5 / 50) * 1.1).ceil();
  }

  int get minefieldMarker {
    return ((2 * branchingLaneDepth / 50) * 1.1).ceil();
  }

  String hourFormat(TimeOfDay time) {
    String hour = "00" + time.hour.toString();
    String minute = "00" + time.minute.toString();
    return (hour.substring(hour.length - 2) +
        minute.substring(minute.length - 2));
  }

  Fraction convertToFraction(String val) {
    return double.tryParse(val) != null
        ? Fraction.fromDouble(double.parse(val))
        : Fraction.fromString(val);
  }
}
