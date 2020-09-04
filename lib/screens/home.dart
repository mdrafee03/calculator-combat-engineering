import 'package:flutter/material.dart';

import '../router/route_const.dart';
import '../shared/widgets/button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combat Engineering'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(context, 'COUNTER MOBILITY TASK', counterMobilityScreen),
            SizedBox(height: 10),
            Button(context, 'MOBILITY TASK', mobility),
          ],
        ),
      ),
    );
  }
}
