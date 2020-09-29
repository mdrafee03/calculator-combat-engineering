import 'package:combat_engineering/shared/widgets/button_with_image.dart';
import 'package:flutter/material.dart';

import '../../../router/route_const.dart';

class MobilityScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Mobility'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ButtonWithImage(
              context: context,
              imageUrl: 'assets/images/icons/hpb.png',
              routeName: heavyPontoonBridgeList,
            ),
            ButtonWithImage(
              context: context,
              imageUrl: 'assets/images/icons/baily-bridge.png',
              routeName: bailyBridgeList,
            ),
            ButtonWithImage(
              context: context,
              imageUrl: 'assets/images/icons/minefield-breaching.png',
              routeName: minefieldBreachingList,
            ),
          ],
        ),
      ),
    );
  }
}
