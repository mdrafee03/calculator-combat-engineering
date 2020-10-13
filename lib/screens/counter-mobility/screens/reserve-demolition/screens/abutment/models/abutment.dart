import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../shared/models/pdfTheme.dart';
import '../../../../../../../shared/models/utility.dart';
import '../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../shared/widgets/top_header_pw.dart';

class Abutment {
  static List<Map<String, dynamic>> typesOfTarget = [
    {"type": "Masonry Abutment", "value": 50},
    {"type": "Roads/Medium and Hard soil", "value": 100},
    {"type": "Soft soil", "value": 200},
  ];
  double width;
  double targetFactor;
  int craterNo;
  double craterDia(int n) {
    if (n == 1) {
      return width;
    } else {
      return (width + width / 3) / n;
    }
  }

  double weightOfCharges(int n) {
    return pow(craterDia(n), 3) / targetFactor;
  }

  double totalChargeRequired(int n) {
    double charge = n * weightOfCharges(n);
    return charge;
  }

  List<double> distanceFromFace(int n) {
    return [craterDia(n) / 2, craterDia(n) / 4];
  }

  double spacingOfCharges(int n) {
    return n == 1 ? 0 : 2 * craterDia(n) / 3;
  }

  double get timeRequiredPerSection {
    return 2 * craterNo / 3;
  }

  double get totalTimeRequired {
    double time =
        (timeRequiredPerSection / 4) >= 1 ? (timeRequiredPerSection / 4) : 1;
    return time;
  }

  List<double> chargesDepth(int n) {
    return [3 * distanceFromFace(n)[0] / 2, 3 * distanceFromFace(n)[1] / 2];
  }

  Future<void> generatePDF(pw.Document doc) async {
    final PdfImage image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/abutment.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw('Summary of abutment demolition'),
            pw.SizedBox(
              height: 20,
            ),
            pw.Container(
              margin: pw.EdgeInsets.all(10),
              child: pw.Column(
                children: [
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      <String>[
                        "No of Charge",
                        for (int i = 1; i < 6; i++) i.toString(),
                      ],
                      <String>[
                        'Crater Dia in ft',
                        for (int i = 1; i < 6; i++)
                          craterDia(i).toStringAsFixed(2)
                      ],
                      <String>[
                        'Each Charges in lbs',
                        for (int i = 1; i < 6; i++)
                          weightOfCharges(i).toStringAsFixed(2)
                      ],
                      <String>[
                        'Total Explosive in lbs',
                        for (int i = 1; i < 6; i++)
                          totalChargeRequired(i).toStringAsFixed(2)
                      ],
                      <String>[
                        'Distance from face in ft',
                        for (int i = 1; i < 6; i++)
                          "${distanceFromFace(i)[0].toStringAsFixed(2)} - ${distanceFromFace(i)[1].toStringAsFixed(2)}"
                      ],
                      <String>[
                        'Spacing of charges in ft',
                        for (int i = 1; i < 6; i++)
                          spacingOfCharges(i).toStringAsFixed(2)
                      ],
                      <String>[
                        'Charges Depth in ft',
                        for (int i = 1; i < 6; i++)
                          "${chargesDepth(i)[0].toStringAsFixed(2)} - ${chargesDepth(i)[1].toStringAsFixed(2)}"
                      ],
                    ],
                  ),
                ],
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.only(left: 10),
              child: pw.Column(
                children: [
                  SectionHeadingPw("1. ", "Summay of Calculation"),
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("a. Method of Attack = Mined Charge"),
                        pw.Text(
                          "b. Type of target = ${Abutment.typesOfTarget.firstWhere((target) => target["value"] == targetFactor)['type']}",
                        ),
                        pw.Text(
                          "c. Total Explosive Require = ${totalChargeRequired(craterNo).toStringAsFixed(2)} lbs",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text("d. Total no of craters = $craterNo"),
                        pw.Text(
                          "e. Crater Dia = ${craterDia(craterNo).toStringAsFixed(2)} ft",
                        ),
                        pw.Text(
                          "f. Distance from face = ${distanceFromFace(craterNo)[0].toStringAsFixed(2)} - ${distanceFromFace(craterNo)[1].toStringAsFixed(2)} ft = ${((distanceFromFace(craterNo)[0] + distanceFromFace(craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                        ),
                        pw.Text(
                          "g. Spacing of Charges = ${spacingOfCharges(craterNo).toStringAsFixed(2)} ft",
                        ),
                        pw.Text(
                          "h. Depth of Charges = ${chargesDepth(craterNo)[0].toStringAsFixed(2)} - ${chargesDepth(craterNo)[1].toStringAsFixed(2)} ft = ${((chargesDepth(craterNo)[0] + chargesDepth(craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.only(left: 10),
              child: pw.Column(
                children: [
                  SectionHeadingPw("2. ", "Time Requirement"),
                  pw.Container(
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.topLeft,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "a. For 3 craters time Requirement 2 section hours.",
                        ),
                        pw.Text(
                          "(Auth: ERPB 1964, Chapter IV, serial 10, page 146)",
                        ),
                        pw.SizedBox(
                          height: 10,
                        ),
                        pw.Wrap(
                          children: [
                            pw.Text(
                              "b. Total Time Require for $craterNo craters ",
                              style: pw.TextStyle(
                                color: PDFTheme.color,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "= ${timeRequiredPerSection.toStringAsFixed(2)} section hours",
                                  style: pw.TextStyle(
                                    color: PDFTheme.color,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  "= $totalTimeRequired Platoon hours",
                                  style: pw.TextStyle(
                                    color: PDFTheme.color,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.only(left: 10),
              child: pw.Column(
                children: [
                  SectionHeadingPw("3. ", "Placement of Charges"),
                  pw.Container(
                    child: pw.Image(image),
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
    final file =
        File("$directory/Abutment${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Abutment.pdf');
  }
}
