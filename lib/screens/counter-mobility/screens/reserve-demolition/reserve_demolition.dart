import 'package:combat_engineering/router/route_const.dart';
import 'package:flutter/material.dart';

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
            Button(context, 'Pier (Masonry/Concrete/RCC/Steel)',
                reserveDemolition),
            SizedBox(height: 10),
            Button(context, 'Span/ Roadway', counterMobility),
            SizedBox(height: 10),
            Button(context, 'Beam/ Girder', counterMobility),
            SizedBox(height: 10),
            Button(context, 'Summary of Reserve Dml', counterMobility),
          ],
        ),
      ),
    );
  }
}
