class TimeHelper {
  static String minuteFormat(int minute) {
    if (minute > 60) {
      return "${(minute / 60).floor()} hours ${(minute % 60).floor()} minutes";
    } else {
      return "${minute.ceil()} minutes";
    }
  }
}
