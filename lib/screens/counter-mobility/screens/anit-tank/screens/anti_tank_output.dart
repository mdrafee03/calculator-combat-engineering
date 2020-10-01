import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:io';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../reserve-demolition/widgets/summary_of_calculation.dart';
import '../../reserve-demolition/widgets/time_requirement.dart';
import '../models/anti_tank.dart';

class AntiTankOutput extends StatelessWidget {
  static GlobalKey screen = new GlobalKey();

  screenShot() async {
    RenderRepaintBoundary boundary = screen.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = '/storage/emulated/0/Download';
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    final AntiTank _model = ModalRoute.of(context).settings.arguments;

    final AppBar appbar = new AppBar(
      title: Text('Anti Tank Ditch'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              antiTankList,
              ModalRoute.withName(counterMobilityScreen),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.file_download),
          onPressed: screenShot,
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: RepaintBoundary(
        key: screen,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                TopHeader("Calculation of Anti-tank ditch"),
                SummaryOfCalculation(),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "a. The width of anti-tank ditch = ${_model.width} yards",
                      ),
                      Text(
                        "b. The height of anti-tank ditch = ${_model.height.toStringAsFixed(2)} yards",
                      ),
                      Text(
                        "c. The volume of anti-tank ditch = ${_model.volume.toStringAsFixed(2)} yards",
                      ),
                    ],
                  ),
                ),
                TimeRequirement(),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "a. Time requirement for 1 Dozon = ${_model.timeRequiredPerDozon.toStringAsFixed(2)} hours",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Note: Capacity of size ii/iv Dozer with 100' half way hauling is 55 cubic yard/hour. (Auth: GSTP-1608Figure 50 page 184)",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "b. Total time require for plant platoon = ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Note: 1x Plant Platoon has 4x Dozer (2x Size-II 2x Size IV)",
                      ),
                    ],
                  ),
                ),
                SectionHeading('3. ', 'Layout of Anti-tank Ditch'),
                Container(
                  child: Image.asset(
                    'assets/images/anti-tank-ditch.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
