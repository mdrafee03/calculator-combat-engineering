import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
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

  TimeOfDay addMinutes(int time) {
    int minute = 0;
    int hour = 0;
    final int hoursToAdd = time ~/ 60;
    final int minutesToAdd = time % 60;
    if (this.minute + minutesToAdd < 60) {
      minute = this.minute + minutesToAdd;
    } else {
      minute = this.minute + minutesToAdd - 60;
      hour += 1;
    }
    if (this.hour + hoursToAdd + hour < 24) {
      hour = this.hour + hoursToAdd + hour;
    } else {
      hour = this.hour + hoursToAdd + hour - 24;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool operator >(TimeOfDay time2) {
    if (this.hour > time2.hour) return true;
    if (this.hour == time2.hour && this.minute > time2.minute) return true;
    return false;
  }

  int operator -(TimeOfDay time2) {
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
    return (hour * 60 + minute);
  }
}
