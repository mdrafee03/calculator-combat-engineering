import 'package:flutter/material.dart';

import '../../../router/route_const.dart';
import '../../../shared/widgets/button.dart';

class MobilityScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Mobility'),
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
            Button(context, 'Heavy Pontoon Bridge', heavyPontoonBridgeList),
            SizedBox(height: 10),
            Button(context, 'Baily Bridge', bailyBridgeList),
            SizedBox(height: 10),
            Button(context, 'Minefield Breaching', counterMobilityScreen),
          ],
        ),
      ),
    );
  }
}
