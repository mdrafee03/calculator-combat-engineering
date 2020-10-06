import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_sub_heading.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../../../screens/reserve-demolition/models/reserve_demolition.dart';

class ReserveDemolitionCombined extends StatelessWidget {
  final List<ReserveDemolition> model;
  final String sl;
  ReserveDemolitionCombined({this.model, this.sl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('$sl. ', 'Store Calculation for Reserve Demoltion'),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              for (int i = 0; i < model.length; i++)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionSubHeading(
                        "${String.fromCharCode(97 + i)}. ",
                        "Reserve Demolition ${i + 1}",
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(i) Plastic Explosive = ${model[i].plasticExplosive.toStringAsFixed(2)}",
                            ),
                            Text(
                              "(ii) Hayrick = ${model[i]?.pier?.shapedCharge?.totalNoOfHyrics ?? 0}",
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
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "(i) Plastic Explosive = ${model.fold<double>(0, (previousValue, element) => previousValue + element.plasticExplosive).toStringAsFixed(2)}",
                          ),
                          Text(
                            "(ii) Hayrick = ${model?.fold(0, (previousValue, element) => previousValue + element.hayrics) ?? 0}",
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
