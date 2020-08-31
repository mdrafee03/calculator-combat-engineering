import 'package:combat_engineering/screens/counter-mobility/screens/wire-obstacle/models/wire_obstacle_task.dart';
import '../../../../../shared/extension-methods/double_apis.dart';

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
    print(type);
    return (value * 1.1).toDoubleAsPrecision().ceil();
  }
}
