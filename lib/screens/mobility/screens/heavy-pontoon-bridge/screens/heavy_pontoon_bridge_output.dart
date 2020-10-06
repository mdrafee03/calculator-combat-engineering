import 'package:flutter/material.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../models/heavy_pontoon_bridge.dart';

class HeavyPontoonBridgeOutput extends StatelessWidget {
  final SerialManage slForBankPart = SerialManage();
  final SerialManage slForParent = SerialManage();
  @override
  Widget build(BuildContext context) {
    final HeavyPontoonBridge _model = ModalRoute.of(context).settings.arguments;
    slForBankPart.reset();
    slForParent.reset();
    final AppBar appbar = new AppBar(
      title: Text('Heavy Pontoon Bridge'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              heavyPontoonBridgeList,
              ModalRoute.withName(mobilityScreen),
            );
          },
        ),
        Builder(builder: (BuildContext ctx) {
          return IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () => _model.savePDF(ctx),
          );
        }),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _model.sharePDF(),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TopHeader('Summary of Heavy Pontoon Bridge'),
              SectionHeading(
                "${slForParent.serialNum} .",
                "Determination of River part",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "a. Number of interior bays = ${_model.numberOfInterior["dividend"]} nos",
                          ),
                          if (_model.numberOfInterior["remainder"] != 0)
                            TextSpan(
                              text:
                                  " remainder ${_model.numberOfInterior["remainder"].toStringAsFixed(2)}m",
                            ),
                        ],
                      ),
                    ),
                    Text(
                      "b. Number of Transporter = ${_model.numberOfTransporter}",
                    ),
                    Text(
                      "c. No of Pontoon Bays = ${_model.numberOfPontoonBays}",
                    ),
                    Text(
                      "d. Length of River Part = ${_model.lengthOfRiverPart.toStringAsFixed(2)} m",
                    ),
                  ],
                ),
              ),
              SectionHeading(
                "${slForParent.serialNum} .",
                "Determination of Bank part",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionSubHeading(
                      "${slForBankPart.serial} .",
                      "No of Pier",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text:
                                      "(1) Number of pier spans nearshore = ${_model.numberOfPierNearshore["dividend"]} nos",
                                ),
                                if (_model.numberOfPierNearshore["remainder"] !=
                                    0)
                                  TextSpan(
                                    text:
                                        " remainder ${_model.numberOfPierNearshore["remainder"].toStringAsFixed(2)}m",
                                  ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        "(2) Number of pier spans farshore = ${_model.numberOfPierFarshore["dividend"]} nos"),
                                if (_model.numberOfPierFarshore["remainder"] !=
                                    0)
                                  TextSpan(
                                    text:
                                        " remainder ${_model.numberOfPierFarshore["remainder"].toStringAsFixed(2)}m",
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SectionSubHeading(
                      "${slForBankPart.serial} .",
                      "Adjustment",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Total Remainder = ${_model.totalRemainder.toStringAsFixed(2)} m",
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "(2) "),
                                  TextSpan(
                                    text: "Solution 1: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  _model.isSolution1Preferred
                                      ? TextSpan(
                                          text:
                                              "Move both piers ${_model.solution1}m towards the current",
                                        )
                                      : TextSpan(
                                          text:
                                              "If the total remainder is divided between the two banks, each bank gets remainder of ${_model.totalRemainder / 2}m that is not possible ",
                                        )
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "(3) "),
                                  TextSpan(
                                    text: "Solution 2: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  if (_model.solution2.increaseSpan != 0)
                                    TextSpan(
                                      text:
                                          "${_model.solution2.increaseSpan} pair span should be added, ",
                                    ),
                                  if (_model.solution2.reduceInterior != 0)
                                    TextSpan(
                                      text:
                                          "${_model.solution2.reduceInterior} interior bay should be reduced, ",
                                    ),
                                  if (_model.solution2.towardsBank != 0)
                                    TextSpan(
                                      text:
                                          "the pier should be moved ${_model.solution2.towardsBank}m to the bank side, ",
                                    ),
                                  if (_model.solution2.towardsCurrent != 0)
                                    TextSpan(
                                      text:
                                          "the pier should be moved ${_model.solution2.towardsCurrent}m to the current side",
                                    ),
                                ]),
                          ),
                          _model.isSolution1Preferred
                              ? Text(
                                  "(4) It is advisable try best not to add pier span or interior bay. So Solution 1 is advisable",
                                )
                              : Text("(4) Solution 2 is advisable"),
                          Text(
                            "(5) Length of Big Ramp on Bank = ${_model.bigRampBank.toStringAsFixed(2)} m",
                          ),
                          Text(
                            "(6) Length of Big Ramp on Water = ${_model.bigRampWater.toStringAsFixed(2)} m",
                          )
                        ],
                      ),
                    ),
                    if (!_model.isSolution1Preferred)
                      Column(
                        children: [
                          SectionSubHeading(
                            "${slForBankPart.serial} .",
                            "Corrected Calculation",
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "(1) Number of interior bays = ${_model.numberOfInteriorCorrected} nos",
                                ),
                                Text(
                                  "(2) Number of transporters = ${_model.numberOfTranporterCorrected} nos",
                                ),
                                Text(
                                  "(3). No of Pontoon Bays = ${_model.numberOfPontoonCorrected} nos",
                                ),
                                Text(
                                  "(4). Length of River Part = ${_model.lengthOfRiverPartCorrected.toStringAsFixed(2)} m",
                                ),
                                Text(
                                  "(5). Number of pier spans near shore = ${_model.numberOfPierNearShoreCorrected} nos",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SectionSubHeading(
                      "${slForBankPart.serial} .",
                      "Length of Pier and Distance from Trestle to Water Edge",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Length of the pier nearshore = ${_model.lengthOfPierNearshore} m",
                          ),
                          Text(
                            "(2) Length of the pier farshore = ${_model.lengthOfPierFarshore} m",
                          ),
                          Text(
                            "(3). Distance from trestle to the water edge = ${_model.distanceTrestleAndWater.toStringAsFixed(2)} m",
                          ),
                        ],
                      ),
                    ),
                    SectionSubHeading(
                      "${slForBankPart.serial} .",
                      "No of Ramp Bays and Transporters",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Number of ramp bays near shore = ${_model.numberOfRampbaysNearshore} nos",
                          ),
                          Text(
                            "(2) Number of ramp bays far shore= ${_model.numberOfRampbaysFarshore} nos",
                          ),
                          Text(
                            "(3). Total number of ramp bays required = ${_model.totalRampbays} nos",
                          ),
                          Text(
                            "(4). Number of ramp bay transporters = ${_model.totalRampbays} nos ",
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SectionSubHeading(
                          "${slForBankPart.serial} .",
                          "Length of Floating Bridge",
                        ),
                        Text(": ${_model.lengthOfFloatingBridge} m")
                      ],
                    ),
                    SectionSubHeading(
                      "${slForBankPart.serial} .",
                      "Number of Laid Anchors",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Upstream anchor = ${_model.laidAnchor[0]} nos",
                          ),
                          Text(
                            "(2) Downstream anchor = ${_model.laidAnchor[1]} nos",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
