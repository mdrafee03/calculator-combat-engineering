import 'package:flutter/material.dart';

import '../../../router/route_const.dart';
import '../../../shared/widgets/background_container.dart';
import '../../../shared/widgets/button_with_image.dart';

class MobilityScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Mobility'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BackgroundContainer(
        child: Container(
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
      ),
    );
  }
}
