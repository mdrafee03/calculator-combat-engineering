import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../../../shared/models/utility.dart';
import '../../../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../../../shared/widgets/top_header_pw.dart';
import '../../../models/reserve_demolition.dart';

class ReserveDemolitionSummary {
  double abutmentCharge = 0;
  double pierCharge = 0;
  double spanCharge = 0;

  double abutmentTime = 0;
  double pierTime = 0;
  double spanTime = 0;
  int sandbag = 0;

  ReserveDemolitionSummary() {
    if (ReserveDemolition.currentReserveDemolition != null) {
      ReserveDemolition _current = ReserveDemolition.currentReserveDemolition;
      _current.listOfAbutment.forEach((element) {
        abutmentCharge += element?.totalChargeRequired(element.craterNo) ?? 0;
        abutmentTime += element?.totalTimeRequired ?? 0;
      });
      pierCharge = _current?.pier?.boreholeCharge?.totalChargeRequired ?? 0;
      pierTime = _current?.pier?.boreholeCharge?.totalTimeRequired ?? 0;

      spanCharge = _current?.spanBeamGirder?.totalChargeRequired ?? 0;
      spanTime = _current?.spanBeamGirder?.totalTimeRequired ?? 0;
      sandbag = _current?.spanBeamGirder?.totalSandbagRequired ?? 0;
    }
  }

  double get totalExplosiveRequired {
    return abutmentCharge + pierCharge + spanCharge;
  }

  double get totalTimeRequired {
    return abutmentTime + pierTime + spanTime;
  }

  int get getSandbag {
    return sandbag;
  }

  Future<void> generatePDF(Document doc) async {
    final PdfImage image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/reserve-demolition/sum.png'))
          .buffer
          .asUint8List(),
    );
    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of reserve demolition of a bridge'),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '1. Total Explosive Required = ${totalExplosiveRequired.toStringAsFixed(2)} lb PE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '2. Total Time Required = ${totalTimeRequired.toStringAsFixed(2)} Platoon hours',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '3. Total Sandbag Required = ${getSandbag.toStringAsFixed(2)} Nos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw(
                      "4. ", "Placement of various charges for demolition"),
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
    final file = File(
        "$directory/Summary-Reserve-Demolition${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(
        bytes: doc.save(), filename: 'Summary-Reserve-Demolition.pdf');
  }
}
