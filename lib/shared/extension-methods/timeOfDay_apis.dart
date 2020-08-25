import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  double differenceInMinutes(TimeOfDay time2) {
    int minute = 0;
    int hour = 0;
    if (this.minute >= time2.minute) {
      minute = this.minute - time2.minute;
    } else {
      minute = this.minute + 60 - time2.minute;
      hour -= 1;
    }
    if (this.hour >= time2.hour) {
      hour += this.hour - time2.hour;
    } else {
      hour += this.hour + 24 - time2.hour;
    }
    return (hour * 60 + minute).toDouble();
  }

  TimeOfDay addMinute(double minuteToAdd) {
    int minute = 0;
    int hour = 0;
    if (this.minute + (minuteToAdd % 60).floor() < 60) {
      minute = this.minute + minuteToAdd.floor();
    } else {
      minute = this.minute + (minuteToAdd % 60).floor() - 60;
      hour += 1;
    }
    if (this.hour + (minuteToAdd / 60).floor() + hour < 24) {
      hour = this.hour + (minuteToAdd / 60).floor() + hour;
    } else {
      hour = this.hour + (minuteToAdd / 60).floor() + hour - 24;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }
}
