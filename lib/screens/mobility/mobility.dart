import 'package:flutter/material.dart';

import '../../router/route_const.dart';
import '../../shared/widgets/button.dart';

class Mobility extends StatelessWidget {
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
            Button(context, 'Heavy Pontoon Bridge', counterMobility),
            SizedBox(height: 10),
            Button(context, 'Baily Bridge', counterMobility),
            SizedBox(height: 10),
            Button(context, 'Minefield Breaching', counterMobility),
          ],
        ),
      ),
    );
  }
}