import 'package:flutter/material.dart';

import '../../../../../shared/models/serial_manage.dart';
import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/top_header.dart';
import '../models/combined_project.dart';
import '../widgets/minefield_laying_combined.dart';
import '../widgets/reserve_demolition_combined.dart';
import '../widgets/store_list_combined.dart';
import '../widgets/wire_obstacle_combined.dart';
import '../widgets/time_combined.dart';

class CombinedProjectOutput extends StatelessWidget {
  final SerialManage slForParent = SerialManage();
  @override
  Widget build(BuildContext context) {
    slForParent.reset();
    final CombinedProject _model = ModalRoute.of(context).settings.arguments;
    _model.taskDistributionCalculation();

    final AppBar appbar = AppBar(
      title: Text('Combined Project'),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              counterMobilityScreen,
              ModalRoute.withName(home),
            );
          },
        ),
        Builder(builder: (BuildContext ctx) {
          return IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () => _model.savePDF(ctx),
          );
        }),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _model.sharePDF(),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TopHeader("Combined Project"),
              if (_model.minefields.length > 0)
                MinefieldLayingCombined(
                  model: _model.minefields,
                  sl: this.slForParent.serialNum.toString(),
                ),
              if (_model.reserveDemolitions.length > 0)
                ReserveDemolitionCombined(
                  model: _model.reserveDemolitions,
                  sl: this.slForParent.serialNum.toString(),
                ),
              if (_model.wireObstacles.length > 0)
                WireObstacleCombined(
                  model: _model.wireObstacles,
                  sl: this.slForParent.serialNum.toString(),
                ),
              StoreListCombined(
                model: _model,
                sl: this.slForParent.serialNum.toString(),
              ),
              TimeCombined(
                model: _model,
                sl: this.slForParent.serialNum.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
