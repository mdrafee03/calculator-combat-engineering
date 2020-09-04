import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../../../../shared/widgets/summary_of_calculation.dart';
import '../../../../../shared/widgets/time_requirement.dart';
import '../models/anti_tank.dart';

class AntiTankOutput extends StatelessWidget {
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
              HeadingOutput("Calculation of Anti-tank ditch"),
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
    );
  }
}
