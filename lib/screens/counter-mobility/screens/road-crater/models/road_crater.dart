import 'dart:io';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  Future<void> generatePDF(pw.Document doc) async {
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw('Summary of Road Crater'),
            pw.Container(
              child: pw.Column(
                children: [
                  SectionHeadingPw("1. ", "Summay of Calculation"),
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "a. Dia of the Road crater = 20'",
                        ),
                        pw.Text(
                          "b. Depth of the Road crater = 7'",
                        ),
                        pw.Text(
                          "c. Explosive required in one crater = 70 lb PE",
                        ),
                        pw.Text(
                          "d. Individuals crater should be 80' apart",
                        ),
                        pw.Text(
                          "e. Line of group craters should be 10' apart",
                        ),
                        pw.Text(
                          "f. Total no of road crater along road width = $totalRoadCraterAlongRoadWidh",
                        ),
                        pw.Text(
                          "g. Total no of Line of group craters along road length = $totalLineOfGroupAlongRoadLength Nos",
                        ),
                        pw.Text(
                          "h. Total no of Road crater = $totalRoadCrater Nos",
                        ),
                        pw.Text(
                          "j. Amount of charge required = ${totalChargeRequired.toStringAsFixed(2)} lb PE",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(
              child: pw.Column(
                children: [
                  SectionHeadingPw("2. ", "Time Requirement"),
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Wrap(
                      children: [
                        pw.Text(
                          "a. Time require for road crater ",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "= $totalTimeRequiredPerSection section hours ",
                              style: pw.TextStyle(
                                color: PDFTheme.color,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "= ${totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                              style: pw.TextStyle(
                                color: PDFTheme.color,
                                fontWeight: pw.FontWeight.bold,
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

  void savePDF(BuildContext ctx) async {
    var doc = pw.Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File("$directory/Road-Crater.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Road-Crater.pdf');
  }
}
