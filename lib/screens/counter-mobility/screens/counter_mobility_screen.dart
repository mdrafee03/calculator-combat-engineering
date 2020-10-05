import 'package:combat_engineering/shared/widgets/background_container.dart';
import 'package:flutter/material.dart';

import '../../../router/route_const.dart';
import '../../../shared/widgets/button_with_image.dart';

class CounterMobilityScreen extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Counter Mobility'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          BackgroundContainer(child: null),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/minefield-laying.png',
                    routeName: minefieldLayingList,
                  ),
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/reserve-demolition.png',
                    routeName: reserveDemolitionList,
                  ),
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/wire-obstacle.png',
                    routeName: wireObstacleList,
                  ),
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/road_catering.png',
                    routeName: roadwayList,
                  ),
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/anti-tank.png',
                    routeName: antiTankList,
                  ),
                  ButtonWithImage(
                    context: context,
                    imageUrl: 'assets/images/icons/combined.png',
                    routeName: combinedProjectInput,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
