import './taskforce.dart';

class TaskDistribution {
  String name;
  double time;
  Taskforce force;
  int priority;
  double startDay;
  double endDay;
  bool startForce;
  bool showTaskforce;
  TaskDistribution({
    this.name,
    this.time,
    this.force,
    this.priority,
    this.startDay,
    this.endDay,
    this.startForce,
    this.showTaskforce = false,
  });
  static List<TaskDistribution> taskDistributions = [];
}
