import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/section_heading.dart';
import '../../../../../../../shared/widgets/top_header.dart';
import '../models/reserve_demolition_summary.dart';

class ReserveDemolitionSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReserveDemolitionSummary _model = ReserveDemolitionSummary();
    final AppBar appbar = AppBar(
      title: Text("Summay"),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(reserveDemolitionChildren),
            );
          },
        ),
        if (Platform.isAndroid)
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
              TopHeader('Summary of reserve demolition of a bridge'),
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
              SectionHeading(
                  '4. ', 'Placement of various charges for demolition'),
              Container(
                child: Image.asset(
                  'assets/images/reserve-demolition/sum.png',
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
