import 'package:flutter/material.dart';

import '../../../../../shared/widgets/section_heading.dart';
import '../models/combined_project.dart';
import '../models/task_distribution.dart';

class TimeCombined extends StatelessWidget {
  const TimeCombined({
    Key key,
    @required CombinedProject model,
  })  : _model = model,
        super(key: key);

  final CombinedProject _model;
  int get numberOfCol => TaskDistribution.taskDistributions.fold(
        0,
        (previousValue, element) => element.endDay > previousValue
            ? element.endDay.ceil()
            : previousValue,
      );
  TableCell buildTableHeader(String title) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading('5. ', 'Work Program'),
        Container(
          width: 1400,
          height: _model.totalCount * 30.toDouble(),
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: FlexColumnWidth(20),
                  columnWidths: {
                    0: FixedColumnWidth(20),
                    1: FixedColumnWidth(140),
                    2: FixedColumnWidth(20),
                    3: FixedColumnWidth(20),
                    4: FixedColumnWidth(50),
                    for (int i = 0; i < numberOfCol; i++)
                      i + 5: FixedColumnWidth(20),
                  },
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      buildTableHeader('Ser'),
                      buildTableHeader('Task'),
                      buildTableHeader('Task Force'),
                      buildTableHeader('Pri'),
                      buildTableHeader('Pl Hr'),
                      for (int i = 0; i < numberOfCol; i++)
                        buildTableHeader((_model.dateTableHeaderFormat(
                            _model.startDate.add(Duration(days: i))))),
                    ]),
                    for (int i = 0;
                        i < TaskDistribution.taskDistributions.length;
                        i++)
                      TableRow(
                        children: [
                          TableCell(
                            child: Text((i + 1).toString()),
                          ),
                          TableCell(
                            child: Text(
                                TaskDistribution.taskDistributions[i].name),
                          ),
                          TableCell(
                            child: Text(TaskDistribution
                                .taskDistributions[i].force.name),
                          ),
                          TableCell(
                            child: Text(
                              TaskDistribution.taskDistributions[i].priority
                                  .toString(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              TaskDistribution.taskDistributions[i].time
                                  .toStringAsFixed(2),
                            ),
                          ),
                          ...List.generate(numberOfCol, (index) {
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
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 20 * (startDay - index),
                                      right: 20 * (1 - (endDay - index))),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else if (startDay - index < 1 &&
                                  startDay - index >= 0) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 20 * (startDay - index)),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else if (endDay - index < 1 &&
                                  endDay - index >= 0) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: 20 * (1 - (endDay - index))),
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              } else {
                                return Container(
                                  color: TaskDistribution
                                      .taskDistributions[i].force.color,
                                  child: Text(''),
                                );
                              }
                            } else {
                              return Text("");
                            }
                          }),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
