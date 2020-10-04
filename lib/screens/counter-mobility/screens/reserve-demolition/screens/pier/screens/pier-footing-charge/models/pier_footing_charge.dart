import 'dart:io';
import 'package:combat_engineering/shared/models/pdfTheme.dart';
import 'package:combat_engineering/shared/widgets/section_sub_heading_pw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../../../shared/models/utility.dart';
import '../../../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../../../shared/widgets/top_header_pw.dart';

class PierFootingCharge {
  double width;
  double thickness;
  int noOfPier;

  double get explosivePerCharge {
    int factor = thickness <= 6 ? 10 : 20;
    return factor * thickness;
  }

  int get totalNoOfCharge {
    return (width / thickness).ceil();
  }

  double get amountOfChargePerPier {
    return explosivePerCharge * totalNoOfCharge;
  }

  double get totalAmountOfCharge {
    return amountOfChargePerPier * noOfPier;
  }

  double get outerCharges {
    return thickness / 2 * 12;
  }

  double get innerCharges {
    return thickness * 12;
  }

  double get totalTimeRequired {
    int timePerSection = width <= 20 ? 2 : 3;
    return (noOfPier * timePerSection / 4) >= 1
        ? (noOfPier * timePerSection / 4)
        : 1;
  }

  Future<void> generatePDF(pw.Document doc) async {
    final PdfImage image1 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load(
              'assets/images/reserve-demolition/pier_footing_charge1.png'))
          .buffer
          .asUint8List(),
    );
    final PdfImage image2 = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load(
              'assets/images/reserve-demolition/pier_footing_charge2.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            TopHeaderPw('Demolition of Pier By Pier Footing Charge'),
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
                          "a. Method of attack = Pier footing charge",
                        ),
                        pw.Text(
                          "b. Amount of expl in one charge = ${explosivePerCharge.toStringAsFixed(2)} lb",
                        ),
                        pw.Text(
                          "c. Amount of charge require for each pier = ${amountOfChargePerPier.toStringAsFixed(2)} lb CE TNT",
                        ),
                        pw.Text(
                          "d. Total amount of charge require for each pier = ${totalAmountOfCharge.toStringAsFixed(2)} lb PE",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        SectionSubHeadingPw("e. ", "Spacing of Charge"),
                        pw.Padding(
                          padding:
                              pw.EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "(1) Dist of outer charges from edges of pier = ${outerCharges.toStringAsFixed(2)}''",
                              ),
                              pw.Text(
                                "(2) Inner charges, charge to charge distance = ${innerCharges.toStringAsFixed(2)}''",
                              ),
                              pw.Text('(3) Charges should be well temped.')
                            ],
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
                          "a. Time requre for demolition of pier ",
                          style: pw.TextStyle(
                            color: PDFTheme.color,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "= ${(totalTimeRequired * 4).toStringAsFixed(2)} section hours",
                              style: pw.TextStyle(
                                color: PDFTheme.color,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "= ${(totalTimeRequired).toStringAsFixed(2)} section hours",
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
          ];
        },
      ),
    );
  }

  void savePDF(BuildContext ctx) async {
    var doc = pw.Document();
    await generatePDF(doc);
    final directory = '/storage/emulated/0/Download';
    final file = File("$directory/Pier-Footing-Charge.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = pw.Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Pier-Footing-Charge.pdf');
  }
}
