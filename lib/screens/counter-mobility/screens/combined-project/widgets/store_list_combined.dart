import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../models/combined_project.dart';

class StoreListCombined extends StatelessWidget {
  const StoreListCombined({
    Key key,
    @required CombinedProject model,
  })  : _model = model,
        super(key: key);

  final CombinedProject _model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('4. ', 'Store List'),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "a. Anti Tank Mines = ${_model.antiTankMines}",
                    ),
                    Text(
                      "b. Anti Personnel Mines = ${_model.antiPersonnelMines}",
                    ),
                    Text(
                      "c. Long Picket = ${_model.longPickets}",
                    ),
                    Text(
                      "d. Short Picket = ${_model.shortPickets}",
                    ),
                    Text(
                      "e. Barbed Wire Coil = ${_model.barbedWireCoil}",
                    ),
                    Text(
                      "f. Perimeter Sign Posting = ${_model.perimeterPosting}",
                    ),
                    Text(
                      "g. Tracing Tape = ${_model.tracingTape}",
                    ),
                    Text(
                      "h. Plastic Explosive = ${_model.plasticExplosive.toStringAsFixed(2)}",
                    ),
                    Text(
                      "j. Sledge hammer = ${_model.sledgeHammer}",
                    ),
                    Text(
                      "k. Wire Cutter = ${_model.wireCutter}",
                    ),
                    Text(
                      "l. Sand Bag = ${_model.sandbag}",
                    ),
                    Text(
                      "m. Windlassing Stick = ${_model.windlassingStick}",
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
