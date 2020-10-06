import 'dart:io';
import 'package:combat_engineering/shared/models/serial_manage.dart';
import 'package:combat_engineering/shared/widgets/section_sub_heading_pw.dart';
import 'package:flutter/material.dart' as m;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/top_header_pw.dart';
import '../../../../../shared/extension-methods/double_apis.dart';
import '../models/laid_anchor_hpb.dart';
import './remainder_hpb.dart';

class HeavyPontoonBridge {
  int classification;
  int numberOfLanes;
  double currentVelocity;
  double distanceNearShore;
  double distanceFarShore;
  double riverWidth;

  Map<String, dynamic> get numberOfInterior {
    double interior = riverWidth - (distanceNearShore + distanceFarShore);
    return {"dividend": (interior ~/ 2.7), "remainder": (interior % 2.7)};
  }

  int get numberOfTransporter {
    return (numberOfInterior["dividend"] / 2).floor();
  }

  int get numberOfPontoonBays {
    return (numberOfInterior["dividend"] / 4).floor();
  }

  double get lengthOfRiverPart {
    return numberOfInterior["dividend"] * 2.7;
  }

  Map<String, dynamic> get numberOfPierNearshore {
    double pier = (distanceNearShore - 2);
    return {"dividend": (pier ~/ 5), "remainder": (pier % 5)};
  }

  Map<String, dynamic> get numberOfPierFarshore {
    double pier = (distanceFarShore - 2);
    return {"dividend": (pier ~/ 5), "remainder": (pier % 5)};
  }

  double get totalRemainder {
    double remainders = (numberOfInterior["remainder"] +
        numberOfPierNearshore["remainder"] +
        numberOfPierFarshore["remainder"]);
    return remainders.toDoubleAsPrecision();
  }

  bool get isSolution1Preferred {
    return totalRemainder <= 2.0;
  }

  double get solution1 {
    return RemainderHPB.listOfRemainder
        .firstWhere((element) => totalRemainder / 2 <= element.remainder)
        .towardsCurrent;
  }

  RemainderHPB get solution2 {
    return RemainderHPB.listOfRemainder
        .firstWhere((element) => totalRemainder <= element.remainder);
  }

  double get bigRampBank {
    if (isSolution1Preferred) {
      return 3.7 - (2 + solution1);
    } else {
      return (3.7 - (2 + solution2.towardsCurrent - solution2.towardsBank));
    }
  }

  double get bigRampWater {
    return 3.7 - bigRampBank;
  }

  int get numberOfInteriorCorrected {
    return numberOfInterior["dividend"] - solution2.reduceInterior;
  }

  int get numberOfTranporterCorrected {
    return (numberOfInteriorCorrected / 2).floor();
  }

  int get numberOfPontoonCorrected {
    return (numberOfInteriorCorrected / 4).floor();
  }

  double get lengthOfRiverPartCorrected {
    return numberOfInteriorCorrected * 2.7;
  }

  int get numberOfPierNearShoreCorrected {
    return numberOfPierNearshore["dividend"] + solution2.increaseSpan;
  }

  int get numberOfPierNearshorePreferred => isSolution1Preferred
      ? numberOfPierNearshore["dividend"]
      : numberOfPierNearShoreCorrected;

  double get lengthOfPierNearshore {
    return 5 * numberOfPierNearshorePreferred + 3.7;
  }

  double get lengthOfPierFarshore {
    return 5 * numberOfPierFarshore["dividend"] + 3.7;
  }

  double get distanceTrestleAndWater {
    return lengthOfPierNearshore - bigRampBank;
  }

  int get numberOfRampbaysNearshore {
    int factor = numberOfLanes == 1 ? 2 : 4;
    return numberOfPierNearshorePreferred * factor;
  }

  int get numberOfRampbaysFarshore {
    int factor = numberOfLanes == 1 ? 2 : 4;
    return numberOfPierFarshore["dividend"] * factor;
  }

  int get totalRampbays {
    return numberOfRampbaysNearshore + numberOfRampbaysFarshore;
  }

  double get lengthOfFloatingBridge {
    double river =
        isSolution1Preferred ? lengthOfRiverPart : lengthOfRiverPartCorrected;
    return river + lengthOfPierNearshore + lengthOfPierFarshore;
  }

  List<int> get laidAnchor {
    int interior = isSolution1Preferred
        ? numberOfInterior["dividend"]
        : numberOfInteriorCorrected;
    LaidAnchorHPB anchor = LaidAnchorHPB.listOfLaidAnchor.firstWhere(
        (element) =>
            currentVelocity <= element.current &&
            element.type == classification);
    return [
      (interior * anchor.upstream).ceil(),
      (interior * anchor.downstream).ceil()
    ];
  }

  Future<void> generatePDF(Document doc) async {
    final slForParent = SerialManage();
    final slForBankPart = SerialManage();
    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of Heavy Pontoon Bridge'),
            SectionHeadingPw(
              "${slForParent.serialNum} .",
              "Determination of River part",
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: PdfColors.black),
                      children: [
                        TextSpan(
                          text:
                              "a. Number of interior bays = ${numberOfInterior["dividend"]} nos",
                        ),
                        if (numberOfInterior["remainder"] != 0)
                          TextSpan(
                            text:
                                " remainder ${numberOfInterior["remainder"].toStringAsFixed(2)}m",
                          ),
                      ],
                    ),
                  ),
                  Text(
                    "b. Number of Transporter = $numberOfTransporter",
                  ),
                  Text(
                    "c. No of Pontoon Bays = $numberOfPontoonBays",
                  ),
                  Text(
                    "d. Length of River Part = ${lengthOfRiverPart.toStringAsFixed(2)} m",
                  ),
                ],
              ),
            ),
            SectionHeadingPw(
              "${slForParent.serialNum} .",
              "Determination of Bank part",
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionSubHeadingPw(
                    "${slForBankPart.serial} .",
                    "No of Pier",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: PdfColors.black),
                            children: [
                              TextSpan(
                                text:
                                    "(1) Number of pier spans nearshore = ${numberOfPierNearshore["dividend"]} nos",
                              ),
                              if (numberOfPierNearshore["remainder"] != 0)
                                TextSpan(
                                  text:
                                      " remainder ${numberOfPierNearshore["remainder"].toStringAsFixed(2)}m",
                                ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: PdfColors.black),
                            children: [
                              TextSpan(
                                  text:
                                      "(2) Number of pier spans farshore = ${numberOfPierFarshore["dividend"]} nos"),
                              if (numberOfPierFarshore["remainder"] != 0)
                                TextSpan(
                                  text:
                                      " remainder ${numberOfPierFarshore["remainder"].toStringAsFixed(2)}m",
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SectionSubHeadingPw(
                    "${slForBankPart.serial} .",
                    "Adjustment",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "(1) Total Remainder = ${totalRemainder.toStringAsFixed(2)} m",
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: PdfColors.black),
                              children: [
                                TextSpan(text: "(2) "),
                                TextSpan(
                                  text: "Solution 1: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                isSolution1Preferred
                                    ? TextSpan(
                                        text:
                                            "Move both piers ${solution1}m towards the current",
                                      )
                                    : TextSpan(
                                        text:
                                            "If the total remainder is divided between the two banks, each bank gets remainder of ${totalRemainder / 2}m that is not possible ",
                                      )
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: PdfColors.black),
                              children: [
                                TextSpan(text: "(3) "),
                                TextSpan(
                                  text: "Solution 2: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                if (solution2.increaseSpan != 0)
                                  TextSpan(
                                    text:
                                        "${solution2.increaseSpan} pair span should be added, ",
                                  ),
                                if (solution2.reduceInterior != 0)
                                  TextSpan(
                                    text:
                                        "${solution2.reduceInterior} interior bay should be reduced, ",
                                  ),
                                if (solution2.towardsBank != 0)
                                  TextSpan(
                                    text:
                                        "the pier should be moved ${solution2.towardsBank}m to the bank side, ",
                                  ),
                                if (solution2.towardsCurrent != 0)
                                  TextSpan(
                                    text:
                                        "the pier should be moved ${solution2.towardsCurrent}m to the current side",
                                  ),
                              ]),
                        ),
                        isSolution1Preferred
                            ? Text(
                                "(4) It is advisable try best not to add pier span or interior bay. So Solution 1 is advisable",
                              )
                            : Text("(4) Solution 2 is advisable"),
                        Text(
                          "(5) Length of Big Ramp on Bank = ${bigRampBank.toStringAsFixed(2)} m",
                        ),
                        Text(
                          "(6) Length of Big Ramp on Water = ${bigRampWater.toStringAsFixed(2)} m",
                        )
                      ],
                    ),
                  ),
                  if (!isSolution1Preferred)
                    Column(
                      children: [
                        SectionSubHeadingPw(
                          "${slForBankPart.serial} .",
                          "Corrected Calculation",
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Number of interior bays = $numberOfInteriorCorrected nos",
                              ),
                              Text(
                                "(2) Number of transporters = $numberOfTranporterCorrected nos",
                              ),
                              Text(
                                "(3). No of Pontoon Bays = $numberOfPontoonCorrected nos",
                              ),
                              Text(
                                "(4). Length of River Part = ${lengthOfRiverPartCorrected.toStringAsFixed(2)} m",
                              ),
                              Text(
                                "(5). Number of pier spans near shore = $numberOfPierNearShoreCorrected nos",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SectionSubHeadingPw(
                    "${slForBankPart.serial} .",
                    "Length of Pier and Distance from Trestle to Water Edge",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "(1) Length of the pier nearshore = $lengthOfPierNearshore m",
                        ),
                        Text(
                          "(2) Length of the pier farshore = $lengthOfPierFarshore m",
                        ),
                        Text(
                          "(3). Distance from trestle to the water edge = ${distanceTrestleAndWater.toStringAsFixed(2)} m",
                        ),
                      ],
                    ),
                  ),
                  SectionSubHeadingPw(
                    "${slForBankPart.serial} .",
                    "No of Ramp Bays and Transporters",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "(1) Number of ramp bays near shore = $numberOfRampbaysNearshore nos",
                        ),
                        Text(
                          "(2) Number of ramp bays far shore= $numberOfRampbaysFarshore nos",
                        ),
                        Text(
                          "(3). Total number of ramp bays required = $totalRampbays nos",
                        ),
                        Text(
                          "(4). Number of ramp bay transporters = $totalRampbays nos ",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SectionSubHeadingPw(
                        "${slForBankPart.serial} .",
                        "Length of Floating Bridge",
                      ),
                      Text(": $lengthOfFloatingBridge m")
                    ],
                  ),
                  SectionSubHeadingPw(
                    "${slForBankPart.serial} .",
                    "Number of Laid Anchors",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "(1) Upstream anchor = ${laidAnchor[0]} nos",
                        ),
                        Text(
                          "(2) Downstream anchor = ${laidAnchor[1]} nos",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    final file = File("$directory/Heavy-Pontoon-Bridge.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Heavy-Pontoon-Bridge.pdf');
  }
}
