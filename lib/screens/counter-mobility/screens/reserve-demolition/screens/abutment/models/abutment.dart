import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
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

  Future<void> generatePDF(Document doc) async {
    final PdfImage image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/abutment.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of abutment demolition'),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Table.fromTextArray(
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
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SectionHeadingPw("1. ", "Summay of Calculation"),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("a. Method of Attack = Mined Charge"),
                        Text(
                          "b. Type of target = ${Abutment.typesOfTarget.firstWhere((target) => target["value"] == targetFactor)['type']}",
                        ),
                        Text(
                          "c. Total Explosive Require = ${totalChargeRequired(craterNo).toStringAsFixed(2)} lbs",
                          style: TextStyle(
                            color: PDFTheme.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("d. Total no of craters = $craterNo"),
                        Text(
                          "e. Crater Dia = ${craterDia(craterNo).toStringAsFixed(2)} ft",
                        ),
                        Text(
                          "f. Distance from face = ${distanceFromFace(craterNo)[0].toStringAsFixed(2)} - ${distanceFromFace(craterNo)[1].toStringAsFixed(2)} ft = ${((distanceFromFace(craterNo)[0] + distanceFromFace(craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                        ),
                        Text(
                          "g. Spacing of Charges = ${spacingOfCharges(craterNo).toStringAsFixed(2)} ft",
                        ),
                        Text(
                          "h. Depth of Charges = ${chargesDepth(craterNo)[0].toStringAsFixed(2)} - ${chargesDepth(craterNo)[1].toStringAsFixed(2)} ft = ${((chargesDepth(craterNo)[0] + chargesDepth(craterNo)[1]) / 2.0).toStringAsFixed(2)} ft",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SectionHeadingPw("2. ", "Time Requirement"),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. For 3 craters time Requirement 2 section hours.",
                        ),
                        Text(
                          "(Auth: ERPB 1964, Chapter IV, serial 10, page 146)",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "b. Total Time Require for $craterNo craters ",
                              style: TextStyle(
                                color: PDFTheme.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "= ${timeRequiredPerSection.toStringAsFixed(2)} section hours",
                                  style: TextStyle(
                                    color: PDFTheme.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "= $totalTimeRequired Platoon hours",
                                  style: TextStyle(
                                    color: PDFTheme.color,
                                    fontWeight: FontWeight.bold,
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
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SectionHeadingPw("3. ", "Placement of Charges"),
                  Container(
                    child: Image(image),
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
    final file =
        File("$directory/Abutment${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Abutment.pdf');
  }
}
