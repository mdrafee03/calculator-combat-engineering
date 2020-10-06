import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/top_header_pw.dart';

class AntiTank {
  double length;

  final double width = 4.83;
  final double height = 5 / 3;

  double get volume {
    return length * height * width;
  }

  double get timeRequiredPerDozon {
    return volume / 55;
  }

  double get totalTimeRequired {
    double time = timeRequiredPerDozon / 4;
    return time <= 1 ? 1 : time;
  }

  Future<void> generatePDF(pw.Document doc) async {
    final PdfImage image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/anti-tank-ditch.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            color: PdfColors.white,
            margin: pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                TopHeaderPw("Calculation of Anti-tank ditch"),
                SectionHeadingPw("1. ", "Summary of Calculation"),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 20),
                  alignment: pw.Alignment.topLeft,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "a. The width of anti-tank ditch = $width yards",
                      ),
                      pw.Text(
                        "b. The height of anti-tank ditch = ${height.toStringAsFixed(2)} yards",
                      ),
                      pw.Text(
                        "c. The volume of anti-tank ditch = ${volume.toStringAsFixed(2)} yards",
                      ),
                    ],
                  ),
                ),
                SectionHeadingPw("2. ", "Time Requirement"),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 20),
                  alignment: pw.Alignment.topLeft,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "a. Time requirement for 1 Dozon = ${timeRequiredPerDozon.toStringAsFixed(2)} hours",
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                        "Note: Capacity of size ii/iv Dozer with 100' half way hauling is 55 cubic yard/hour. (Auth: GSTP-1608Figure 50 page 184)",
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                        "b. Total time require for plant platoon = ${totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Text(
                        "Note: 1x Plant Platoon has 4x Dozer (2x Size-II 2x Size IV)",
                      ),
                    ],
                  ),
                ),
                SectionHeadingPw("3. ", "Layout of Anti-tank Ditch"),
                pw.Container(
                  child: pw.Image(image),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void savePDF(BuildContext ctx) async {
    var doc = pw.Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File("$directory/Anti-tank.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Anti-tank.pdf');
  }
}
