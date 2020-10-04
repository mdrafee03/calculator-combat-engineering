import 'dart:math';
import 'dart:io';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../shared/models/utility.dart';
import '../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../shared/widgets/top_header_pw.dart';

import './time_manpower.dart';

class SpanBeamGirder {
  double length;
  double thicknessOfRoadway;
  double thicknessOfBeam;
  double height;
  double width;
  int noOfBeams;
  int noOfSpans;

  double get chargeOfEachBeam {
    return (4 *
        pow(((height + thicknessOfRoadway) / 12), 2) *
        (thicknessOfBeam / 12));
  }

  double get totalChargeBeams {
    return chargeOfEachBeam * noOfBeams;
  }

  double get totalChargeRequired {
    double charge = totalChargeBeams * noOfSpans;
    return charge;
  }

  int get sanbagPerSpan {
    return (20 / 25 * totalChargeBeams).ceil();
  }

  int get totalSandbagRequired {
    int sandbag = (sanbagPerSpan * noOfSpans);
    return sandbag;
  }

  int get timeRequiredPerSection {
    TimeManpower timeManpower = listOfTimeAndManpower.firstWhere(
      (element) =>
          width > element.width[0] &&
          width <= element.width[1] &&
          length > element.length[0] &&
          length <= element.length[1],
    );
    return noOfSpans * timeManpower.time * timeManpower.manpower;
  }

  double get totalTimeRequired {
    double time =
        (timeRequiredPerSection / 4) >= 1 ? (timeRequiredPerSection / 4) : 1;
    return time;
  }

  Future<void> generatePDF(pw.Document doc) async {
    final PdfImage image1 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/span_beam_girder1.png'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image2 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/span_beam_girder2.png'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image3 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle
              .load('assets/images/reserve-demolition/span_beam_girder3.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw(
                'Demolition of Span, Beam And Girder By Pressure Charge'),
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
                          "a. Charge of each beam = ${chargeOfEachBeam.toStringAsFixed(2)} lb",
                        ),
                        pw.Text(
                          "b. Total amount of charge require for $noOfBeams beams = ${totalChargeBeams.toStringAsFixed(2)} lb PE",
                        ),
                        pw.Text(
                          "c. Total charge require for $noOfSpans spans = ${totalChargeRequired.toStringAsFixed(2)} lb PE",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          "d. Sand Bag Require for one span = $sanbagPerSpan Nos",
                        ),
                        pw.Text(
                          "e. Total Sand Bag Required for demolition of spans = $totalSandbagRequired Nos",
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
                    child: pw.Wrap(
                      children: [
                        pw.Text(
                          "a. Total time require for demolition one $noOfSpans Spans ",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "= $timeRequiredPerSection section hours ",
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
            pw.Container(
              child: pw.Column(
                children: [
                  SectionHeadingPw("3. ", "Placement of Charges"),
                  pw.Container(
                    child: pw.Image(image1),
                  ),
                ],
              ),
            ),
            pw.Container(
              child: pw.Image(image2),
            ),
            pw.Container(
              child: pw.Image(image3),
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
    final file = File("$directory/Span-Beam-Girder.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Span-Beam-Girder.pdf');
  }
}
