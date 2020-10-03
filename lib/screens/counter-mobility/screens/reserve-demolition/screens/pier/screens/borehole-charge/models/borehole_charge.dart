import 'dart:io';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../../../shared/models/utility.dart';
import '../../../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../../../shared/widgets/top_header_pw.dart';
import 'borehole_charge_type.dart';
import 'borehole_charge_calc.dart';

class BoreholeCharge {
  double width;
  double thickness;
  BoreholeChargeType typeOfBoreholePier;
  int row;
  int noOfPier;

  int totalTime;
  double totalCharge;

  int get noOfHolesPerRow {
    return (width / 3).round();
  }

  int get totalNoOfholes {
    if (typeOfBoreholePier.id == "4") {
      return noOfHolesPerRow * (row * 2) - row;
    } else {
      return noOfHolesPerRow * row - (row ~/ 2);
    }
  }

  int get depthOfHole {
    if (typeOfBoreholePier.id == "4") {
      return (thickness / 2 * 12).ceil();
    } else {
      return ((2 * thickness / 3) * 12).ceil();
    }
  }

  int get depthOfExplosiveToBeFilled {
    return (depthOfHole / 2).ceil();
  }

  List<BoreholeChargeCalc> get chargeAndTimeCalucation {
    List<BoreholeChargeCalc> chargesNTimes = [];
    if (depthOfHole > 40) {
      chargesNTimes.add(
        new BoreholeChargeCalc(
          dia: 2,
          depth: 40 - depthOfHole / 2,
          timeDepth: 40,
          time: 7 * 40 / 12,
          charge: (40 - depthOfHole.toDouble() / 2) * 2.5,
        ),
      );
      if (depthOfHole > 60) {
        chargesNTimes.add(
          new BoreholeChargeCalc(
            dia: 1.75,
            depth: 20,
            timeDepth: 20,
            time: 6 * 20 / 12,
            charge: 20.0 * 2,
          ),
        );
        chargesNTimes.add(
          new BoreholeChargeCalc(
            dia: 1.5,
            depth: (depthOfHole - 60).toDouble(),
            timeDepth: (depthOfHole - 60).toDouble(),
            time: (5 * (depthOfHole - 60) / 12),
            charge: (depthOfHole - 60) * 1.5,
          ),
        );
      } else {
        chargesNTimes.add(
          new BoreholeChargeCalc(
            dia: 1.75,
            depth: (depthOfHole.toDouble() - 40),
            timeDepth: (depthOfHole.toDouble() - 40),
            time: (6 * (depthOfHole.toDouble() - 40) / 12),
            charge: (depthOfHole.toDouble() - 40) * 2,
          ),
        );
      }
    } else {
      chargesNTimes.add(
        new BoreholeChargeCalc(
          dia: 2,
          depth: depthOfHole / 2,
          timeDepth: depthOfHole.toDouble(),
          time: 7 * depthOfHole.toDouble() / 12,
          charge: (depthOfHole.toDouble() / 2) * 2.5,
        ),
      );
    }
    totalTime =
        chargesNTimes.fold(0, (value, element) => value + element.time).ceil();
    totalCharge =
        chargesNTimes.fold(0, (value, element) => value + element.charge);
    return chargesNTimes;
  }

  double get totalChargeRequiredOnePier {
    return totalNoOfholes * totalCharge / 16;
  }

  double get totalTimeRequired {
    double time = (totalTime * totalNoOfholes / 2) / 60;
    return time;
  }

  double get totalChargeRequired {
    double charge = noOfPier * totalChargeRequiredOnePier;
    return charge;
  }

  Future<void> generatePDF(pw.Document doc) async {
    final PdfImage image1 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/borehole1.png'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image2 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/borehole2.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw('Demolition of pier by borehole charge'),
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
                          "a. No of holes require one row = $noOfHolesPerRow Nos",
                        ),
                        pw.Text(
                          "b. No of rows = $row Nos",
                        ),
                        pw.Text(
                          "c. Total no of holes = $totalNoOfholes Nos",
                        ),
                        pw.Text(
                          "d. Depth of hole = $depthOfHole''",
                        ),
                        pw.Text(
                          "e. Distance between rows of borehole = $depthOfHole''",
                        ),
                        pw.Text(
                          "f. Depth of explosive to be filled in borehole = $depthOfExplosiveToBeFilled''",
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "g. Dia of borehole",
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.only(
                                  left: 20, top: 5, bottom: 5),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  if (chargeAndTimeCalucation.length > 1)
                                    pw.Text(
                                        "(1) 2.0'' dia borehole will be filled with mud up to initial $depthOfExplosiveToBeFilled'' depth"),
                                  for (int i = 0;
                                      i < chargeAndTimeCalucation.length;
                                      i++)
                                    pw.Text(
                                        "(${chargeAndTimeCalucation.length > 1 ? i + 2 : i + 1}) ${chargeAndTimeCalucation[i].dia}'' dia borehole to be filled with explosive up to initial ${chargeAndTimeCalucation[i].depth}'' depth")
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Text(
                          "h. Charge required in one hole = ${totalCharge.toStringAsFixed(2)} oz PE",
                        ),
                        pw.Text(
                          "h. Charge required in one hole = ${totalCharge.toStringAsFixed(2)} oz PE",
                        ),
                        pw.Text(
                          "h. Charge required in one hole = ${totalCharge.toStringAsFixed(2)} oz PE",
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
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < chargeAndTimeCalucation.length;
                                i++)
                              pw.Text(
                                  "${String.fromCharCode(97 + i)}. Time require for making ${chargeAndTimeCalucation[i].timeDepth} inch borehole = ${chargeAndTimeCalucation[i].time.toStringAsFixed(2)} minute")
                          ],
                        ),
                        pw.Text(
                            "    (Auth: ERPB 1964, Section 26, Note (i) and serial 5)"),
                        pw.SizedBox(
                          height: 10,
                        ),
                        pw.Text(
                          "${String.fromCharCode(97 + chargeAndTimeCalucation.length)}. Total time requirement for demolition of $noOfPier piers = ${totalTimeRequired.toStringAsFixed(2)} hr",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
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
                  SectionHeadingPw("3. ", "Placement of Charges"),
                  pw.Container(
                    child: pw.Image(image1),
                  ),
                  pw.Container(
                    child: pw.Image(image2),
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
    final file = File("$directory/Borehole-Charge.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Borehole-Charge.pdf');
  }
}
