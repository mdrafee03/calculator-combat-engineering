import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/pdfTheme.dart';
import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/top_header_pw.dart';

class RoadCrater {
  double width;
  double length;
  final dia = 20;
  final depth = 7;
  final explosivePerCrater = 70;
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

  double get totalChargeRequired {
    double charge = (totalRoadCrater * explosivePerCrater).toDouble();
    return charge;
  }

  int get totalTimeRequiredPerSection {
    return (totalRoadCrater * 2 / 3).ceil();
  }

  double get totalTimeRequired {
    double time = totalTimeRequiredPerSection / 4 >= 1
        ? totalTimeRequiredPerSection / 4
        : 1;
    return time;
  }

  Future<void> generatePDF(Document doc) async {
    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of Road Crater'),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw("1. ", "Summay of Calculation"),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. Dia of the Road crater = 20'",
                        ),
                        Text(
                          "b. Depth of the Road crater = 7'",
                        ),
                        Text(
                          "c. Explosive required in one crater = 70 lb PE",
                        ),
                        Text(
                          "d. Individuals crater should be 80' apart",
                        ),
                        Text(
                          "e. Line of group craters should be 10' apart",
                        ),
                        Text(
                          "f. Total no of road crater along road width = $totalRoadCraterAlongRoadWidh",
                        ),
                        Text(
                          "g. Total no of Line of group craters along road length = $totalLineOfGroupAlongRoadLength Nos",
                        ),
                        Text(
                          "h. Total no of Road crater = $totalRoadCrater Nos",
                        ),
                        Text(
                          "j. Amount of charge required = ${totalChargeRequired.toStringAsFixed(2)} lb PE",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw("2. ", "Time Requirement"),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: [
                        Text(
                          "a. Time require for road crater ",
                          style: TextStyle(
                            color: PDFTheme.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "= $totalTimeRequiredPerSection section hours ",
                              style: TextStyle(
                                color: PDFTheme.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "= ${totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                              style: TextStyle(
                                color: PDFTheme.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    final file = File(
        "$directory/Road-Crater${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Road-Crater.pdf');
  }
}
