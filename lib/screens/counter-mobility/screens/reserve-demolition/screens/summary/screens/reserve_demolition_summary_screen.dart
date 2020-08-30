import 'package:flutter/material.dart';

import '../models/reserve_demolition_summary.dart';
import '../../../../../../../shared/widgets/heading_output.dart';

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
              HeadingOutput('Summary of reserve demolition of a bridge'),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '1. Total Explosive Required = ${_model.totalExplosiveRequired.toStringAsFixed(2)} lb PE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '2. Total Time Required = ${_model.totalTimeRequired.toStringAsFixed(2)} Platoon hours',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '3. Total Sandbag Required = ${_model.getSandbag.toStringAsFixed(2)} Nos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
