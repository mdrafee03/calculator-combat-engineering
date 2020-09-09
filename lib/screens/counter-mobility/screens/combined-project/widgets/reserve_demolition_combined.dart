import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../../../screens/reserve-demolition/models/reserve_demolition.dart';

class ReserveDemolitionCombined extends StatelessWidget {
  const ReserveDemolitionCombined({
    Key key,
    @required List<ReserveDemolition> model,
  })  : _model = model,
        super(key: key);

  final List<ReserveDemolition> _model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('2. ', 'Store Calculation for Reserve Demoltion'),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              for (int i = 0; i < _model.length; i++)
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${String.fromCharCode(97 + i)}. Reserve Demolition ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(i) Plastic Explosive = ${_model[i].plasticExplosive.toStringAsFixed(2)}",
                            ),
                            Text(
                              "(ii) Hayrick = ${_model[i]?.pier?.shapedPier?.totalNoOfHyrics != null ? _model[i].pier.shapedPier?.totalNoOfHyrics : "null"}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Stores for all Reserve Demolition",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Plastic Explosive = ${_model.fold<double>(0, (previousValue, element) => previousValue + element.plasticExplosive).toStringAsFixed(2)}",
                          ),
                          Text(
                            "(ii) Hayrick = ${_model.fold(0, (previousValue, element) => previousValue + element?.pier?.shapedPier?.totalNoOfHyrics ?? 0)}",
                          ),
                        ],
                      ),
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
