import 'package:flutter/material.dart';

import '../models/reserve_demolition_summary.dart';

class ReserveDemolitionSummaryScreen extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Reserve Demolition Summary'),
  );
  @override
  Widget build(BuildContext context) {
    final ReserveDemolitionSummary _model = ReserveDemolitionSummary();
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
                  'SUMMARY OF RESERVE DEMOLISTION',
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
                      'Total Explosive Required',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                    Text(
                      " = ${_model.totalExplosiveRequired.toStringAsFixed(2)} lb PE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      'Total Time Required',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                    Text(
                      " = ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      'Sandbag',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                    Text(
                      " = ${_model.getSandbag.toStringAsFixed(2)} Nos",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
