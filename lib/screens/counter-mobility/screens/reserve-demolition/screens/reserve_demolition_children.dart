import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/button.dart';
import '../models/reserve_demolition.dart';

class ReserveDemolitionChildren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Reserve Demolition'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              reserveDemolitionList,
              ModalRoute.withName(counterMobilityScreen),
            );
          },
        )
      ],
    );
    ReserveDemolition _reserveDemolition =
        ModalRoute.of(context).settings.arguments;
    ReserveDemolition.currentReserveDemolition = _reserveDemolition;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(context, 'Abutment (Masonry/Concrete)', abutmentList),
            SizedBox(height: 10),
            Button(context, 'Pier (Masonry/Concrete/RCC/Steel)', pierScreen),
            SizedBox(height: 10),
            Button(context, 'Span, Beam and Girder', spanBeamGirderInput),
            SizedBox(height: 10),
            Button(context, 'Summary of Reserve Demolition',
                reserveDemolitionSummary),
          ],
        ),
      ),
    );
  }
}
