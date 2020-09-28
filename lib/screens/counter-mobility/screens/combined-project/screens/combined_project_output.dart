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
    if (_model.minefields.length > 0 &&
        _model.reserveDemolitions.length > 0 &&
        _model.wireObstacles.length > 0 &&
        _model.antiTanks.length > 0) {
      _model.taskDistributionCalculation();
    }
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
              if (_model.minefields.length > 0)
                MinefieldLayingCombined(model: _model.minefields),
              if (_model.reserveDemolitions.length > 0)
                ReserveDemolitionCombined(model: _model.reserveDemolitions),
              if (_model.wireObstacles.length > 0)
                WireObstacleCombined(model: _model.wireObstacles),
              if (_model.minefields.length > 0 &&
                  _model.reserveDemolitions.length > 0 &&
                  _model.wireObstacles.length > 0 &&
                  _model.antiTanks.length > 0)
                StoreListCombined(model: _model),
              if (_model.minefields.length > 0 &&
                  _model.reserveDemolitions.length > 0 &&
                  _model.wireObstacles.length > 0 &&
                  _model.antiTanks.length > 0)
                TimeCombined(model: _model),
            ],
          ),
        ),
      ),
    );
  }
}
