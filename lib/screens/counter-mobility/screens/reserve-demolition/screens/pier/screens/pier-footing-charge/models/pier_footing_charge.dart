import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../../../../../shared/models/pdfTheme.dart';
import '../../../../../../../../../shared/models/utility.dart';
import '../../../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../../../shared/widgets/section_sub_heading_pw.dart';
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

  Future<void> generatePDF(Document doc) async {
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
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Demolition of Pier By Pier Footing Charge'),
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
                          "a. Method of attack = Pier footing charge",
                        ),
                        Text(
                          "b. Amount of expl in one charge = ${explosivePerCharge.toStringAsFixed(2)} lb",
                        ),
                        Text(
                          "c. Amount of charge require for each pier = ${amountOfChargePerPier.toStringAsFixed(2)} lb CE TNT",
                        ),
                        Text(
                          "d. Total amount of charge require for each pier = ${totalAmountOfCharge.toStringAsFixed(2)} lb PE",
                          style: TextStyle(
                            color: PDFTheme.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SectionSubHeadingPw("e. ", "Spacing of Charge"),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Dist of outer charges from edges of pier = ${outerCharges.toStringAsFixed(2)}''",
                              ),
                              Text(
                                "(2) Inner charges, charge to charge distance = ${innerCharges.toStringAsFixed(2)}''",
                              ),
                              Text('(3) Charges should be well temped.')
                            ],
                          ),
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
                          "a. Time requre for demolition of pier ",
                          style: TextStyle(
                            color: PDFTheme.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "= ${(totalTimeRequired * 4).toStringAsFixed(2)} section hours",
                              style: TextStyle(
                                color: PDFTheme.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "= ${(totalTimeRequired).toStringAsFixed(2)} section hours",
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
            Container(
              child: Column(
                children: [
                  SectionHeadingPw("3. ", "Placement of Charges"),
                  Container(
                    child: Image(image1),
                  ),
                ],
              ),
            ),
            Container(
              child: Image(image2),
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
        "$directory/Pier-Footing-Charge${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Pier-Footing-Charge.pdf');
  }
}
