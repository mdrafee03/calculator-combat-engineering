class TimeManpower {
  List<int> width;
  List<int> length;
  int time;
  int manpower;
  TimeManpower(this.width, this.length, this.time, this.manpower);
}

List<TimeManpower> listOfTimeAndManpower = [
  new TimeManpower([0, 20], [10, 40], 4, 1),
  new TimeManpower([0, 20], [40, 80], 5, 1),
  new TimeManpower([0, 20], [80, 100000], 6, 1),
  new TimeManpower([20, 100000], [10, 40], 4, 2),
  new TimeManpower([20, 100000], [40, 80], 5, 2),
  new TimeManpower([20, 100000], [80, 100000], 6, 2),
];
