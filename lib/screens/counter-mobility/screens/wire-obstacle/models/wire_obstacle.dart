import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../shared/models/utility.dart';
import '../../../../../shared/widgets/section_heading_pw.dart';
import '../../../../../shared/widgets/top_header_pw.dart';
import '../../../../../shared/extension-methods/double_apis.dart';
import './wire_obstacle_task.dart';

enum PartsOfDay { Day, Night }

class WireObstacle {
  double frontage;
  int section;
  PartsOfDay time;
  WireObstacleTask task;
  int sl = 0;
  String get getSerial {
    sl++;
    return String.fromCharCode(96 + sl);
  }

  int getValueByFrontage(int type) {
    double value = (type * frontage / 100);
    return (value * 1.1).toDoubleAsPrecision().ceil();
  }

  int getValueBySection(int type) {
    int value = type * section;
    return (value * 1.1).toDoubleAsPrecision().ceil();
  }

  double get timeRequirePerSection {
    int timePer100 =
        time == PartsOfDay.Day ? task.timesForday : task.timesForNight;
    return timePer100 * frontage / 100 / section / 60;
  }

  double get totalTimeRequire {
    double time = timeRequirePerSection * section / 4;
    return time <= 1 ? 1 : time;
  }

  Future<void> generatePDF(Document doc) async {
    final List<PdfImage> images = [];
    for (int i = 0; i < task.images.length; i++) {
      images.add(PdfImage.file(
        doc.document,
        bytes: (await rootBundle.load(task.images[i])).buffer.asUint8List(),
      ));
    }

    doc.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return [
            TopHeaderPw('Summary of Wire Obstacle'),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('1. ', 'Store Calculation'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$getSerial. Barbed wire = ${getValueByFrontage(task.barbedWire)} Nos",
                        ),
                        if ([2, 3, 4, 5, 6].contains(task.id))
                          Text(
                            "$getSerial. Barbed wire concertina = ${getValueByFrontage(task.barbedWireConcertina)} Nos",
                          ),
                        Text(
                          "$getSerial. Long Piquet = ${getValueByFrontage(task.longPicket)} Nos",
                        ),
                        if ([1, 4].contains(task.id))
                          Text(
                            "$getSerial. Short Picket = ${getValueByFrontage(task.shortPiquet)} Nos",
                          ),
                        if ([1, 3, 4].contains(task.id))
                          Text(
                            "$getSerial. Maul/Sledgehammer = ${getValueBySection(task.mauls)} Nos",
                          ),
                        if ([5, 6].contains(task.id))
                          Text(
                            "$getSerial. Tracing tape Roll = ${getValueByFrontage(task.tracingTapRoll)} Nos",
                          ),
                        if ([1, 3, 4, 5, 6].contains(task.id))
                          Text(
                            "$getSerial. Wire Cutter = ${getValueBySection(task.wireCutter)} Nos",
                          ),
                        if ([1, 3, 4, 5, 6].contains(task.id))
                          Text(
                            "$getSerial. Windlassing Sticks = ${getValueBySection(task.windlassingStick)} Nos",
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
                  SectionHeadingPw('2. ', 'Time Calculation'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: [
                        Text(
                          "Time require in ${time == PartsOfDay.Day ? "Day" : "Dark Night"} ",
                        ),
                        Column(
                          children: [
                            Text(
                              "= ${timeRequirePerSection.toStringAsFixed(2)} Section hours ",
                            ),
                            Text(
                              "= ${totalTimeRequire.toStringAsFixed(2)} Platoon hours ",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SectionHeadingPw('3. ', 'Manpower Calculation'),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "(1) ${section}x section each having ${task.nco} NCO and ${task.men} men",
                        ),
                        Text(
                          "(2) This group will form ${task.group}",
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
                  SectionHeadingPw('4. ', "Layout of ${task.task}"),
                ],
              ),
            ),
            ...images
                .map(
                  (PdfImage e) => Container(
                    child: Image(e),
                  ),
                )
                .toList(),
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
        "$directory/Wire-Obstacle${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(doc.save());
    Utility.showPrintedToast(ctx);
  }

  void sharePDF() async {
    var doc = Document();
    await generatePDF(doc);
    await Printing.sharePdf(bytes: doc.save(), filename: 'Wire-Obstacle.pdf');
  }
}
