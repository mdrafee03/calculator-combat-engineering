import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/models/utility.dart';
import '../../../../../shared/models/serial_manage.dart';
import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../models/baily_bridge.dart';

class BailyBridgeOutput extends StatelessWidget {
  final SerialManage sl = SerialManage();
  @override
  Widget build(BuildContext context) {
    final BailyBridge _model = ModalRoute.of(context).settings.arguments;
    sl.reset();
    final AppBar appbar = new AppBar(
      title: Text('Baily Bridge'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              bailyBridgeList,
              ModalRoute.withName(mobilityScreen),
            );
          },
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput('Summary of Baily Bridge'),
              SectionHeading('1. ', "Calculation"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${sl.serialNum}. Length of Baily Bridge = ${_model.lengthOfBailyBridge} ft",
                    ),
                    Text(
                      "${sl.serialNum}. Type of Construction of Baily Bridge = ${_model.typesOfConstructionString[_model.typeOfConstructionOfBridge]}",
                    ),
                    Text(
                      "${sl.serialNum}. Length of Nose = ${_model.lengthOfNose} ft = ${(_model.lengthOfNose / 10).round()} Bay ",
                    ),
                    Wrap(
                      children: [
                        Text(
                          "${sl.serialNum}. Type of Construction of of Nose = ${_model.typeOfConstructionOfNose[0]} SS",
                        ),
                        if (_model.typeOfConstructionOfNose[1] != 0)
                          Text(
                            " and ${_model.typeOfConstructionOfNose[1]} DS",
                          ),
                        if (_model.typeOfConstructionOfNose[2] != 0)
                          Text(
                            " and ${_model.typeOfConstructionOfNose[2]} DD",
                          ),
                      ],
                    ),
                    Text(
                      "${sl.serialNum}. Corrected Length of Nose = ${_model.lengthOfNoseCorrected} ft = ${(_model.lengthOfNose / 10).round()} Bay ",
                    ),
                    Text(
                      "${sl.serialNum}. Position of Launching Link = ${_model.positionOfLaunchingLink} Bay ",
                    ),
                    Text(
                      "${sl.serialNum}. Construction Space = ${_model.constructionSpaceRollerLayout} ft",
                    ),
                    Text(
                      "${sl.serialNum}. Position of Construction Roller at = ${_model.positionOfConstructionRoller.join("', ")}'",
                    ),
                    Text(
                      "${sl.serialNum}. No. of Construction roller at each side",
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      alignment: Alignment.topLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _model.numberOfConstructionRollerEachSide
                              .asMap()
                              .map((i, element) => MapEntry(
                                  i,
                                  Text(
                                      "(${Utility.romanize(i + 1)}) At ${element.keys.first}' = ${element.values.first} Nos")))
                              .values
                              .toList()),
                    ),
                    Text(
                      "${sl.serialNum}. No. of Launching Roller = ${_model.numberOfLaunchingRoller} Nos",
                    ),
                    Text(
                      "${sl.serialNum}. No. of Landing Roller = ${_model.numberOfLandingRoller} Nos",
                    ),
                    Text(
                      "${sl.serialNum}. Rocking Rollers = ${_model.numberOfLaunchingRoller + _model.numberOfLandingRoller} Nos",
                    ),
                    Text(
                      "${sl.serialNum}. Plain Rollers = ${_model.plainRoller} Nos",
                    ),
                    Text(
                      "${sl.serialNum}. Total Rollers = ${_model.totalRoller} Nos",
                    ),
                    Text(
                      "${sl.serialNum}. Max Reaction on Baseplate  = ${_model.maxReactionOfBasePlate} ton",
                    ),
                    Text(
                      "${sl.serialNum}. Size of the Baseplate  = ${_model.sizeOfBaseplate} sq ft",
                    ),
                    Text(
                      "${sl.serialNum}. Bearing Pressure on soil  = ${_model.pressureOfSoil} ton/sq ft",
                    ),
                    Text(
                      "${sl.serialNum}. Max Bearing Pressure on soil  = ${_model.maxPressureOnSoil.toStringAsFixed(2)} ton/sq ft",
                    ),
                    _model.isGrillageRequire
                        ? Text("${sl.serialNum}. we'll need Grillage ")
                        : Text("${sl.serialNum}. we won't need Grillage"),
                    if (_model.isGrillageRequire)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sl.serialNum} Type = ${_model.getGrillageLoads.type}, Baseplate = ${_model.getGrillageLoads.basePlate}, template = ${_model.getGrillageLoads.template},",
                          ),
                          Text(
                            "${sl.serialNum} Total Grillage = ${_model.numberOfGrillage} Nos",
                          ),
                        ],
                      ),
                    Text(
                      "${sl.serialNum}. Weight taken By Jack = ${_model.weightOfJack} tons",
                    ),
                    Text(
                      "${sl.serialNum}. Number of Jack require = ${_model.numberOfJack} Nos",
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
