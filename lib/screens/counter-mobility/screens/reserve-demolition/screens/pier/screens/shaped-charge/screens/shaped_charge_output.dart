import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/top_header.dart';
import '../../../../../../../widgets/summary_of_calculation.dart';
import '../../../../../../../widgets/time_requirement.dart';
import '../models/shaped_charge.dart';

class ShapedChargeOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShapedCharge _model = ModalRoute.of(context).settings.arguments;
    final AppBar appbar = new AppBar(
      title: Text("Shaped Charge"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(reserveDemolitionChildren),
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
              TopHeader("Demolition of Pier By Shaped Charge"),
              SummaryOfCalculation(),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Method of Attack = Hayrick (Shaped Charge)",
                    ),
                    Text(
                      "b. Dia of one column, d = ${_model.dia} ft",
                    ),
                    Text(
                      "c. Circumference of one pier = ${_model.circumferencePerPier.toStringAsFixed(2)} ft",
                    ),
                    Text(
                      "d. Number of hayricks required = ${_model.noOfHyricks} Nos",
                    ),
                    Text(
                      "e. Total no of hayricks required for ${_model.noOfPier} piers = ${_model.totalNoOfHyrics} Nos",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TimeRequirement(),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "a. Time require for demolition of ${_model.noOfPier} piers",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "= ${_model.totalTimeRequiredPerSection} section hours ",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "= ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text("   (Auth : FEMW pamph-3 sec 21 Para -7")
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
