class SerialManage {
  int sl;
  SerialManage() {
    sl = 0;
  }
  String get serial {
    sl++;
    String current = String.fromCharCode(96 + sl);
    if (current == "i") {
      sl++;
      return String.fromCharCode(96 + sl);
    } else {
      return current;
    }
  }

  int get serialNum {
    sl++;
    return sl;
  }

  void reset() {
    sl = 0;
  }
}
