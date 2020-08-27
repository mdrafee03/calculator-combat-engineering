import 'package:flutter/material.dart';

import '../../../../../../router/route_const.dart';
import '../../../../../../shared/widgets/button.dart';

class Pier extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Demolition of Pier'),
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
            Button(context, 'Borehole Charge', boreholePierInput),
            SizedBox(height: 10),
            Button(context, 'Shaped Charge', boreholePierInput),
            SizedBox(height: 10),
            Button(context, 'Pier Footing Charge', counterMobility),
          ],
        ),
      ),
    );
  }
}
