import 'package:flutter/material.dart';
import '../../../../../shared/extension-methods/timeOfDay_apis.dart';

class MinefieldTime {
  int dayTaken;
  int timeAvailableADay;
  int timeRequired;
  TimeOfDay firstLight;
  TimeOfDay lastLight;
  double totalTimeRequired;

  String get timeRequiredInMinutes {
    return minuteFormat(timeRequired);
  }

  String get completionTime {
    TimeOfDay finishTime =
        lastLight.addMinutes(timeRequired - dayTaken * timeAvailableADay);
    String finishDay = dayTaken == 0 ? "D-Day" : "D+${dayTaken}Day";
    return "${hourFormat(finishTime)} $finishDay";
  }

  String minuteFormat(int minute) {
    if (minute > 60) {
      return "${(minute / 60).floor()} hours ${(minute % 60).floor()} minutes";
    } else {
      return "${minute.ceil()} minutes";
    }
  }

  String hourFormat(TimeOfDay time) {
    String hour = "00" + time.hour.toString();
    String minute = "00" + time.minute.toString();
    return (hour.substring(hour.length - 2) +
        minute.substring(minute.length - 2));
  }
}
