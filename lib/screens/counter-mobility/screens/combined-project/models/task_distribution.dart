import './taskforce.dart';

class TaskDistribution {
  String name;
  double time;
  Taskforce force;
  int priority;
  double startDay;
  double endDay;
  TaskDistribution({
    this.name,
    this.time,
    this.force,
    this.priority,
    this.startDay,
    this.endDay,
  });
  static List<TaskDistribution> taskDistributions = [];
}
