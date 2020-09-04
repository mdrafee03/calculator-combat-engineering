import 'package:flutter/material.dart';

import '../../router/route_const.dart';
import '../../shared/widgets/button.dart';

class CounterMobilityScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Counter Mobility'),
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
            Button(context, 'Minefield Laying', minefieldLayingList),
            SizedBox(height: 10),
            Button(
                context, 'Reserve Demolition of a Bridge', reserveDemolition),
            SizedBox(height: 10),
            Button(context, 'Wire Obstacle', wireObstacleInput),
            SizedBox(height: 10),
            Button(context, 'Anti-tank ditch', antiTankInput),
            SizedBox(height: 10),
            Button(context, 'Combined Engineer Project', counterMobilityScreen),
          ],
        ),
      ),
    );
  }
}
