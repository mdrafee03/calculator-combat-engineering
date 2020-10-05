import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../models/combined_project.dart';
import '../models/task_distribution.dart';

class TimeCombined extends StatelessWidget {
  final CombinedProject model;
  final String sl;
  TimeCombined({this.model, this.sl});

  int get numberOfCol => TaskDistribution.taskDistributions.fold(
        0,
        (previousValue, element) => element.endDay > previousValue
            ? element.endDay.ceil()
            : previousValue,
      );
  TableCell buildTableHeader(String title) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
        child: Center(
          child: RotatedBox(
            quarterTurns: -1,
            child: Text(
              title,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Container buildTableCell(String cell, {bool isCenter = false}) {
    return Container(
      alignment: isCenter ? Alignment.center : Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
        ),
      ),
      child: Text(cell),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('$sl. ', 'Work Program'),
        Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: FlexColumnWidth(20),
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1),
                    top: BorderSide(width: 1),
                    left: BorderSide(width: 1),
                    right: BorderSide(width: 1),
                    bottom: BorderSide(width: 1),
                  ),
                  columnWidths: {
                    0: FixedColumnWidth(20),
                    1: FixedColumnWidth(140),
                    2: FixedColumnWidth(20),
                    3: FixedColumnWidth(20),
                    4: FixedColumnWidth(50),
                    for (int i = 0; i < numberOfCol; i++)
                      i + 5: FixedColumnWidth(20),
                  },
                  children: [
                    TableRow(
                      children: [
                        buildTableHeader('Ser'),
                        buildTableHeader('Task'),
                        buildTableHeader('Task Force'),
                        buildTableHeader('Pri'),
                        buildTableHeader('Pl Hr'),
                        for (int i = 0; i < numberOfCol; i++)
                          buildTableHeader((model.dateTableHeaderFormat(
                              model.startDate.add(Duration(days: i))))),
                      ],
                    ),
                    for (int i = 0;
                        i < TaskDistribution.taskDistributions.length;
                        i++)
                      TableRow(
                        decoration:
                            TaskDistribution.taskDistributions[i].startForce &&
                                    i != 0
                                ? BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 2),
                                    ),
                                  )
                                : null,
                        children: [
                          buildTableCell((i + 1).toString(), isCenter: true),
                          buildTableCell(
                            TaskDistribution.taskDistributions[i].name,
                          ),
                          Container(
                            decoration: i == 0
                                ? BoxDecoration(
                                    border: Border(top: BorderSide(width: 1)))
                                : null,
                            alignment: Alignment.center,
                            child: Text(
                                TaskDistribution.taskDistributions[i].startForce
                                    ? TaskDistribution
                                        .taskDistributions[i].force.name
                                    : ''),
                          ),
                          buildTableCell(
                              TaskDistribution.taskDistributions[i].priority
                                  .toString(),
                              isCenter: true),
                          buildTableCell(
                            TaskDistribution.taskDistributions[i].time
                                .toStringAsFixed(2),
                          ),
                          ...List.generate(numberOfCol, (index) {
                            Widget temp;
                            if ((index >=
                                    TaskDistribution
                                        .taskDistributions[i].startDay
                                        .floor() &&
                                index <=
                                    TaskDistribution
                                        .taskDistributions[i].endDay)) {
                              double startDay = TaskDistribution
                                  .taskDistributions[i].startDay;
                              double endDay =
                                  TaskDistribution.taskDistributions[i].endDay;
                              if (startDay - index < 1 &&
                                  startDay - index >= 0 &&
                                  endDay - index < 1 &&
                                  endDay - index >= 0) {
                                temp = Container(
                                  margin: EdgeInsets.only(
                                      left: 20 * (startDay - index),
                                      right: 20 * (1 - (endDay - index))),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else if (startDay - index < 1 &&
                                  startDay - index >= 0) {
                                temp = Container(
                                  margin: EdgeInsets.only(
                                      left: 20 * (startDay - index)),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else if (endDay - index < 1 &&
                                  endDay - index >= 0) {
                                temp = Container(
                                  margin: EdgeInsets.only(
                                      right: 20 * (1 - (endDay - index))),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else {
                                temp = Container(
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              }
                            } else {
                              temp = Text("");
                            }
                            return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1),
                                  ),
                                ),
                                child: temp);
                          }),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
