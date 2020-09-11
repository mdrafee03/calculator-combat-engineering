import 'package:flutter/material.dart';

import '../../../../../shared/widgets/heading_output.dart';
import '../models/combined_project.dart';
import '../widgets/minefield_laying_combined.dart';
import '../widgets/reserve_demolition_combined.dart';
import '../widgets/store_list_combined.dart';
import '../widgets/wire_obstacle_combined.dart';
import '../widgets/time_combined.dart';

class CombinedProjectOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CombinedProject _model = ModalRoute.of(context).settings.arguments;
    _model.taskDistributionCalculation();
    final AppBar appbar = new AppBar(
      title: Text('Combined Project'),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput("Combined Project"),
              MinefieldLayingCombined(model: _model.minefields),
              ReserveDemolitionCombined(model: _model.reserveDemolitions),
              WireObstacleCombined(model: _model.wireObstacles),
              StoreListCombined(model: _model),
              TimeCombined(model: _model),
            ],
          ),
        ),
      ),
    );
  }
}
