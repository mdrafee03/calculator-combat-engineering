import 'package:combat_engineering/shared/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../../../../../shared/widgets/button.dart';

class PierScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Demolition of Pier'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(context, 'Borehole Charge', boreholeChargeInput),
              SizedBox(height: 10),
              Button(context, 'Shaped Charge', shapedChargeInput),
              SizedBox(height: 10),
              Button(context, 'Pier Footing Charge', pierFootingChargeInput),
            ],
          ),
        ),
      ),
    );
  }
}
