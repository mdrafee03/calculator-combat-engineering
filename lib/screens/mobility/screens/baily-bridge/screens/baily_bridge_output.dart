import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../../../../../shared/widgets/reference_text.dart';
import '../../../../../shared/widgets/section_sub_heading.dart';
import '../../../../../shared/models/serial_manage.dart';
import '../models/baily_bridge.dart';
import '../widgets/launching_calc.dart';
import '../widgets/store_calc_bb_widget.dart';

class BailyBridgeOutput extends StatelessWidget {
  final SerialManage slForVehicle = SerialManage();
  final SerialManage slForParent = SerialManage();
  @override
  Widget build(BuildContext context) {
    final BailyBridge _model = ModalRoute.of(context).settings.arguments;
    slForVehicle.reset();
    slForParent.reset();
    final AppBar appbar = AppBar(
      title: Text('Baily Bridge'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, bailyBridgeInput, ModalRoute.withName(bailyBridgeList),
                arguments: _model);
          },
        ),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              bailyBridgeList,
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
              TopHeader('Summary of Baily Bridge'),
              SectionSubHeading(
                "${slForParent.serialNum} .",
                "Lenght of Baily Bridge and Type of Construction",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Length of Baily Bridge = ${_model.lengthOfBailyBridge} ft",
                    ),
                    Text(
                      "b. Type of Construction of Baily Bridge = ${_model.typesOfConstructionString[_model.typeOfConstructionOfBridge]}",
                    ),
                    ReferenceText(
                      "(Auth: ERPB-1964, Section 16, Para 6, Table 1)",
                    ),
                  ],
                ),
              ),
              SectionSubHeading(
                "${slForParent.serialNum} .",
                "Launching Nose and Position of Launching Link",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Length of Nose = ${_model.lengthOfNose} ft = ${(_model.lengthOfNose / 10).round()} Bay ",
                    ),
                    Wrap(
                      children: [
                        Text(
                          "b. Type of Construction of of Nose = ${_model.typeOfConstructionOfNose[0]} SS",
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
                    ReferenceText(
                        "(Authorization: ME Volume III, Part III, Figure 33, 34, 35, or 36), Page 149-152"),
                    Text(
                      "c. Corrected Length of Nose = ${_model.lengthOfNoseCorrected} ft = ${(_model.lengthOfNose / 10).round()} Bay ",
                    ),
                    ReferenceText(
                        "(Authorization: ME Volume III, Part III, Figure 33, 34, 35, or 36), Page 149-152"),
                    Text(
                      "d. Position of Launching Link = ${_model.positionOfLaunchingLink} Bay ",
                    ),
                    ReferenceText(
                      "[Auth: ME Volume III, Part III, Section 8, Para 3a] (Page-33)",
                    ),
                  ],
                ),
              ),
              SectionSubHeading(
                "${slForParent.serialNum} .",
                "Roller Layout",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Construction Space = ${_model.constructionSpaceRollerLayout} ft",
                    ),
                    Text(
                      "b. Position of Construction Roller = At a Distance of ${_model.positionOfConstructionRoller.sublist(0, _model.positionOfConstructionRoller.length - 1).map((element) => _model.positionRollersString[element]).join("', ")}' and ${_model.positionRollersString[_model.positionOfConstructionRoller.last]}'",
                    ),
                    ReferenceText(
                      "[Auth: ME Volume III, Part III, Section 8, Part 3a] (Page-33)",
                    ),
                    Row(
                      children: [
                        Text("c. "),
                        Text(
                          "No. of Construction rollers at each side",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
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
                                      "(${i + 1}) At ${element.keys.first}' : ${element.values.first} Nos")))
                              .values
                              .toList()),
                    ),
                    ReferenceText(
                      "(Auth: ERPB Section 16 Para 4c, Page-67; ME Volumne III, Part III, Section 6, Para -4, Page-30)",
                    ),
                    Text(
                      "d. No. of Launching Roller = ${_model.numberOfLaunchingRoller} Nos",
                    ),
                    ReferenceText(
                      "[Auth: ME Volumne III, Part III, Annex A (Page-132) and Section 4, Para 1 (Page-29), Section 6, Para 2 & ERPB Section 16 Para 2 (Page-66)]",
                    ),
                    Text(
                      "e. No. of Landing Roller = ${_model.numberOfLandingRoller} Nos",
                    ),
                    ReferenceText(
                      "(Auth: ME Volume III, Part III, Section 6, Para-3)",
                    ),
                    Row(
                      children: [
                        Text("f. "),
                        Text(
                          "Total Required of Rollers",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(1) Rocking Rollers = ${_model.numberOfLaunchingRoller + _model.numberOfLandingRoller} Nos",
                          ),
                          Text(
                            "(2) Plain Rollers = ${_model.plainRoller} Nos",
                          ),
                          Text(
                            "(3) Total Rollers = ${_model.totalRoller} Nos",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SectionSubHeading(
                "${slForParent.serialNum} .",
                "Grillage",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Maximum base plate reaction = ${_model.maxReactionOfBasePlate} ton",
                    ),
                    ReferenceText(
                      "(Auth: ERPB, Section 16, table under para 13) (Page-83)",
                    ),
                    Text(
                      "b. Size of the Baseplate  = ${_model.sizeOfBaseplate} sq ft",
                    ),
                    ReferenceText("(Auth: ERPB, Section 16, Para 03)"),
                    Text(
                      "c. Given Bearing pressure on soil  = ${_model.pressureOfSoil} ton/sq ft",
                    ),
                    Text(
                      "d. Max Bearing Pressure on soil  = ${_model.maxPressureOnSoil.toStringAsFixed(2)} ton/sq ft",
                    ),
                    _model.isGrillageRequire
                        ? Text("e. Grillage is required")
                        : Text("e. Grillage is not required"),
                    if (_model.isGrillageRequire)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "f. Type of Grillage = ${_model.getGrillageLoads.type}, Baseplate = ${_model.getGrillageLoads.basePlate}, template = ${_model.getGrillageLoads.template},",
                          ),
                          Text(
                            "g. Total no of Grillage = ${_model.numberOfGrillage} Nos",
                          ),
                        ],
                      ),
                    ReferenceText("(Auth: ME Volume III, Part III, Fig: 37"),
                  ],
                ),
              ),
              SectionSubHeading(
                "${slForParent.serialNum} .",
                "Jacks",
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a .Weight on Jack = ${_model.weightOfJack.toStringAsFixed(2)} tons",
                    ),
                    Text(
                      "b. No of Jack require = ${_model.numberOfJack} Nos",
                    ),
                    ReferenceText(
                      "(Auth: ME Volume III part III, Section: 15, Para 1) (Page-42)",
                    ),
                  ],
                ),
              ),
              if (_model.isLunching)
                LaunchingCalcBailyBridge(
                  sl: slForParent.serialNum,
                  lauchings: _model.launchingCalculations,
                  positions: _model.positionOfConstructionRoller,
                  farbank: _model.waterGap,
                ),
              if (_model.isLunching) SizedBox(height: 20),
              StoreCalcBBWidget(
                sl: slForParent.serialNum,
                stores: _model.storeCalculation,
              ),
              SectionSubHeading(
                  "${slForParent.serialNum} .", "Vehicle Require"),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${slForVehicle.serial}. Lorry for Panels = ${_model.lorryForPanels}",
                    ),
                    Text(
                      "${slForVehicle.serial}. Lorry for Decking  = ${_model.lorryForDecking}",
                    ),
                    Text(
                      "${slForVehicle.serial}. Ramps  = 2 x Lorry",
                    ),
                    if (_model.isGrillageRequire)
                      Text(
                        "${slForVehicle.serial}. Grillage  = ${_model.lorryForGrillage}",
                      ),
                    Text(
                      "${slForVehicle.serial}. Total Lorry= ${_model.totalLorry}",
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/baily-bridge/bb1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/baily-bridge/bb2.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/baily-bridge/bb3.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
