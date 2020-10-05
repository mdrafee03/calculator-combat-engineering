import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../models/combined_project.dart';

class StoreListCombined extends StatelessWidget {
  final CombinedProject model;
  final String sl;
  StoreListCombined({this.model, this.sl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('$sl. ', 'Store List for Combined Engineer Project'),
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
                      "a. Anti Tank Mines = ${model.antiTankMines}",
                    ),
                    Text(
                      "b. Anti Personnel Mines = ${model.antiPersonnelMines}",
                    ),
                    Text(
                      "c. Long Picket = ${model.longPickets}",
                    ),
                    Text(
                      "d. Short Picket = ${model.shortPickets}",
                    ),
                    Text(
                      "e. Barbed Wire Coil = ${model.barbedWireCoil}",
                    ),
                    Text(
                      "f. Perimeter Sign Posting = ${model.perimeterPosting}",
                    ),
                    Text(
                      "g. Tracing Tape = ${model.tracingTape}",
                    ),
                    Text(
                      "h. Plastic Explosive = ${model.plasticExplosive.toStringAsFixed(2)}",
                    ),
                    Text(
                      "j. Sledge hammer = ${model.sledgeHammer}",
                    ),
                    Text(
                      "k. Wire Cutter = ${model.wireCutter}",
                    ),
                    Text(
                      "l. Sand Bag = ${model.sandbag}",
                    ),
                    Text(
                      "m. Windlassing Stick = ${model.windlassingStick}",
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
