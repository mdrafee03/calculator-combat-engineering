import 'package:flutter/material.dart';

import '../models/footing_pier.dart';

class FootingPierOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Pier Footing Charge Result'),
  );
  @override
  Widget build(BuildContext context) {
    final FootingPier _footing = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SUMMARY OF PIER FOOTING CHARGE RESULT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      'Calculation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Amount of explosive in one charge = ${_footing.explosivePerCharge.toStringAsFixed(2)} lb",
                    ),
                    Text(
                      "b. No of charge = ${_footing.totalNoOfCharge} Nos",
                    ),
                    Text(
                      "c. Total amount of charge required = ${_footing.totalAmountCharge.toStringAsFixed(2)} lb CE TNT",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("d. Spacing of charge",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(i) Dist of outer charges from edges of pier = ${_footing.outerCharges.toStringAsFixed(2)}''",
                              ),
                              Text(
                                "(ii) Inner charges, charge to charge distance = ${_footing.innerCharges.toStringAsFixed(2)}''",
                              ),
                              Text('(iii) Charges should be well temped.')
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text("e.")
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
