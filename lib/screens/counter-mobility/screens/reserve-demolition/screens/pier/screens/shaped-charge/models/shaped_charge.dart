import 'dart:io';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../../../shared/models/utility.dart';
import '../../../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../../../shared/widgets/top_header_pw.dart';

class ShapedCharge {
  double dia;
  int noOfPier;

  double get circumferencePerPier {
    return 3.14 * dia;
  }

  int get noOfHyricks {
    return (circumferencePerPier * 12 / 6).ceil();
  }

  int get totalNoOfHyrics {
    return noOfHyricks * noOfPier;
  }

  int get totalTimeRequiredPerSection {
    return (noOfPier * 4).ceil();
  }

  double get totalTimeRequired {
    return (totalTimeRequiredPerSection / 4) >= 1
        ? (totalTimeRequiredPerSection / 4)
        : 1;
  }

  Future<void> generatePDF(pw.Document doc) async {
    // final PdfImage image1 = PdfImage.file(
    //   doc.document,
    //   bytes: (await rootBundle
    //           .load('assets/images/reserve-demolition/borehole1.png'))
    //       .buffer
    //       .asUint8List(),
    // );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw('Demolition of Pier By Shaped Charge'),
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
                          "a. Method of Attack = Hayrick (Shaped Charge)",
                        ),
                        pw.Text(
                          "b. Dia of one column, d = $dia ft",
                        ),
                        pw.Text(
                          "c. Circumference of one pier = ${circumferencePerPier.toStringAsFixed(2)} ft",
                        ),
                        pw.Text(
                          "d. Number of hayricks required = $noOfHyricks Nos",
                        ),
                        pw.Text(
                          "e. Total no of hayricks required for $noOfPier piers = $totalNoOfHyrics Nos",
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
                  SectionHeadingPw("2. ", "Time Requirement"),
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Wrap(
                          children: [
                            pw.Text(
                              "a. Time require for demolition of $noOfPier piers ",
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
                        pw.Text("   (Auth : FEMW pamph-3 sec 21 Para -7")
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
    final file = File(
        "$directory/Shaped-Charge${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Shaped-Charge.pdf');
  }
}
