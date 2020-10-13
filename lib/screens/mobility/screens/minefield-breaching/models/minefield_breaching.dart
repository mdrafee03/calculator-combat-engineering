import 'dart:io';
import 'package:combat_engineering/shared/models/utility_pw.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:fraction/fraction.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/section_sub_heading_pw.dart';
import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/top_header_pw.dart';

import "../../../../../shared/extension-methods/timeOfDay_apis.dart";
import '../models/breaching_lane.dart';

class MinefieldBreaching {
  Fraction density;
  int noOfFieldEngineerPlatoon;
  int noOfInfantryPlatoon;
  int noOfAssaultPioneerPlatoon;
  m.TimeOfDay firstLight = m.TimeOfDay.now();
  m.TimeOfDay lastLight = m.TimeOfDay.now();
  m.TimeOfDay startTime = m.TimeOfDay.now();
  int branchingLaneDepth;
  int restTime;
  m.TimeOfDay completionTime;
  int completionDay;

  List<BreachingLaneList> get timeCalculation {
    List<BreachingLaneList> breachingLaneList =
        determineSteps(branchingLaneDepth);
    int day = 0;
    m.TimeOfDay currentTime = startTime;

    List<BreachingLane> createBreachingLane(
      int type,
      m.TimeOfDay start,
      bool first,
      bool last,
    ) {
      m.TimeOfDay current = start;
      List<BreachingLane> breachingLanes = [];
      m.TimeOfDay addedTime;
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

  String hourFormat(m.TimeOfDay time) {
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

  Future<void> generatePDF(Document doc) async {
    final slForParent = SerialManage();
    final PdfImage image1 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load(
              'assets/images/minefield-breaching/minefield-breaching1.jpg'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image2 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load(
              'assets/images/minefield-breaching/minefield-breaching2.jpg'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of Minefield Breaching'),
            SectionHeadingPw(
              "${slForParent.serialNum} .",
              "Time Calculation",
            ),
            for (int i = 0; i < timeCalculation.length; i++)
              Column(
                children: [
                  SectionSubHeadingPw("${String.fromCharCode(i + 97)}. ",
                      "For${i != 0 ? " Next" : ""} ${timeCalculation[i].type} yards (Depth ${timeCalculation[i].depth} yards)"),
                  Table(
                    border: TableBorder(
                      horizontalInside: false,
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(25),
                      3: FixedColumnWidth(40),
                      4: FixedColumnWidth(50),
                      5: FixedColumnWidth(50),
                    },
                    children: [
                      TableRow(
                        children: [
                          UtilityPw.buildTableHeader("Ser"),
                          UtilityPw.buildTableHeader("Party"),
                          UtilityPw.buildTableHeader("Task"),
                          UtilityPw.buildTableHeader("Time"),
                          UtilityPw.buildTableHeader("From"),
                          UtilityPw.buildTableHeader("To"),
                        ],
                      ),
                      ...timeCalculation[i].branchingLane.map((lane) {
                        return TableRow(
                          children: [
                            lane.startParty
                                ? UtilityPw.buildTableCell(
                                    lane.serial.toString(),
                                    isCenter: true,
                                  )
                                : Text(""),
                            lane.startParty
                                ? UtilityPw.buildTableCell(lane.party)
                                : Text(""),
                            UtilityPw.buildTableCell(lane.task),
                            UtilityPw.buildTableCell(lane.time.toString(),
                                isCenter: true),
                            UtilityPw.buildTableCell(hourFormat(lane.from),
                                isCenter: true),
                            UtilityPw.buildTableCell(hourFormat(lane.to),
                                isCenter: true),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            SectionHeadingPw(
              "${slForParent.serialNum} .",
              "Store Calculation",
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "a. Prismatic Compass = 03 Nos",
                  ),
                  Text(
                    "b. Short Prodder = 30 Nos",
                  ),
                  Text(
                    "c. Trip Wine Feeler = 30 Nos",
                  ),
                  Text(
                    "d. Wire Cutters = 150 Nos",
                  ),
                  Text(
                    "e. Eye Protector = One Per man",
                  ),
                  Text(
                    "f. Reel of Fish line = 30 Nos",
                  ),
                  Text(
                    "g. Store for lane marking",
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
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
                          "(1) Long Picket = $longPicket Nos",
                        ),
                        Text(
                          "(2) Barbed Wire Coil = $barbedWire Nos",
                        ),
                        Text(
                          "(3) Safe Lane Marker = $safeLaneMarker Nos",
                        ),
                        Text(
                          "(4) Green Light = Yellow light = $greenYellowLight Nos",
                        ),
                        Text(
                          "(5) Cncertina Coil = 4 Coils",
                        ),
                        Text(
                          "(6) Tape = $tape Nos",
                        ),
                        Text(
                          "(7) Minefield Marker = $minefieldMarker Nos",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SectionHeadingPw(
              "${slForParent.serialNum} .",
              "Summary of Calculation",
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "(1) Start Time = ${hourFormat(startTime)} hours D Day",
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: PdfColors.black),
                      children: [
                        TextSpan(
                          text:
                              "(2) Completion Time = ${hourFormat(completionTime)} hours D",
                        ),
                        if (completionDay != 0)
                          TextSpan(
                            text: "+$completionDay",
                          ),
                        TextSpan(
                          text: " Day",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Image(image1),
            Image(image2),
          ];
        },
      ),
    );
  }

  void savePDF(m.BuildContext ctx) async {
    var doc = Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File(
        "$directory/Minefield-Breaching${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Minefield-Breaching.pdf');
  }
}
