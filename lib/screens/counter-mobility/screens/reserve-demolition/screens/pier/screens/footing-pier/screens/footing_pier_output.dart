import 'package:flutter/material.dart';

import '../../../../../../../../../router/route_const.dart';
import '../../../../../../../../../shared/widgets/heading_output.dart';
import '../../../../../../../../../shared/widgets/placement_of_charges.dart';
import '../../../../../../../../../shared/widgets/summary_of_calculation.dart';
import '../../../../../../../../../shared/widgets/time_requirement.dart';

import '../models/footing_pier.dart';

class FootingPierOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FootingPier _model = ModalRoute.of(context).settings.arguments;
    final AppBar appbar = new AppBar(
      title: Text('Pier Footing Charge'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(reserveDemolitionChildren),
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
              HeadingOutput("Demolition of Pier By Pier Footing Charge"),
              SummaryOfCalculation(),
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
                      "b. Amount of expl in one charge = ${_model.explosivePerCharge.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "b. No of charge = ${_model.totalNoOfCharge} Nos",
                    ),
                    Text(
                      "c. Amount of charge require for each pier = ${_model.amountOfChargePerPier.toStringAsFixed(2)} lb CE TNT",
                    ),
                    Text(
                      "d. Total amount of charge require for each pier = ${_model.totalAmountOfCharge.toStringAsFixed(2)} lb CE TNT",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              "e. ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Spacing of charge",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Dist of outer charges from edges of pier = ${_model.outerCharges.toStringAsFixed(2)}''",
                              ),
                              Text(
                                "(2) Inner charges, charge to charge distance = ${_model.innerCharges.toStringAsFixed(2)}''",
                              ),
                              Text('(3) Charges should be well temped.')
                            ],
                          ),
                        ),
                      ],
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
                  children: [
                    Text(
                      "a. Time requre for demolition of pier ",
                      style: TextStyle(
                        color: Color(0xFF00008B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "= ${(_model.totalTimeRequired * 4).toStringAsFixed(2)} section hours",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "= ${(_model.totalTimeRequired).toStringAsFixed(2)} section hours",
                          style: TextStyle(
                            color: Color(0xFF00008B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              PlacementOfCharges(),
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/pier_footing_charge1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/pier_footing_charge2.png',
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
