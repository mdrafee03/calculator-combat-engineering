import './taskforce.dart';

class TaskDistribution {
  String name;
  double time;
  Taskforce force;
  int priority;
  double startDay;
  double endDay;
  bool startForce;
  TaskDistribution({
    this.name,
    this.time,
    this.force,
    this.priority,
    this.startDay,
    this.endDay,
    this.startForce,
  });
  static List<TaskDistribution> taskDistributions = [];
}
