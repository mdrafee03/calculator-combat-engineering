import 'package:flutter/material.dart';

import '../../../../router/route_const.dart';
import '../../../../shared/widgets/button.dart';

class ReserveDemolition extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Reserve Demolition'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(context, 'Abutment (Masonry/Concrete)', abutmentInput),
            SizedBox(height: 10),
            Button(context, 'Pier (Masonry/Concrete/RCC/Steel)', pier),
            SizedBox(height: 10),
            Button(context, 'Span, Beam and Girder', spanBeamGirderInput),
            SizedBox(height: 10),
            Button(context, 'Roadway', roadwayInput),
            SizedBox(height: 10),
            Button(context, 'Summary of Reserve Demolition',
                reserveDemolitionSummary),
          ],
        ),
      ),
    );
  }
}
