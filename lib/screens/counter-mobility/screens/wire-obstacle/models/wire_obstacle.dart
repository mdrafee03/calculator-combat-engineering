import '../../../../../shared/extension-methods/double_apis.dart';
import './wire_obstacle_task.dart';

enum PartsOfDay { Day, Night }

class WireObstacle {
  double frontage;
  int section;
  PartsOfDay time;
  WireObstacleTask task;
  int sl = 0;
  String get getSerial {
    sl++;
    return String.fromCharCode(96 + sl);
  }

  int getValueByFrontage(int type) {
    double value = (type * frontage / 100);
    return (value * 1.1).toDoubleAsPrecision().ceil();
  }

  int getValueBySection(int type) {
    int value = type * section;
    return (value * 1.1).toDoubleAsPrecision().ceil();
  }

  double get timeRequire {
    int timePer100 =
        time == PartsOfDay.Day ? task.timesForday : task.timesForNight;
    double totalHour = timePer100 * frontage / 100 / section / 60;
    return totalHour >= 1 ? totalHour : 1;
  }
}
