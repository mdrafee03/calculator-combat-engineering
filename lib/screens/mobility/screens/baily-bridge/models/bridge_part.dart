import '../models/baily_bridge.dart';

class BridgePart {
  String name;
  MainBarPart head;
  MainBarPart intermediate;
  MainBarPart tail;
  BridgePart(this.name, this.head, this.intermediate, this.tail);
  static List<BridgePart> listOfBridgePart = [
    BridgePart(
      "Baseplate",
      MainBarPart(2, 2, 2, 2),
      MainBarPart(0, 0, 0, 0),
      MainBarPart(2, 2, 2, 2),
    ),
    BridgePart(
      "Footwalk",
      MainBarPart(6, 6, 6, 6),
      MainBarPart(4, 4, 4, 4),
      MainBarPart(4, 4, 4, 4),
    ),
    BridgePart(
      "Panel",
      MainBarPart(2, 4, 8, 8),
      MainBarPart(2, 4, 8, 12),
      MainBarPart(2, 4, 8, 8),
    ),
    BridgePart(
      "End post",
      MainBarPart(2, 4, 4, 4),
      MainBarPart(0, 0, 0, 0),
      MainBarPart(2, 4, 4, 4),
    ),
    BridgePart(
      "Raker",
      MainBarPart(4, 4, 4, 4),
      MainBarPart(2, 2, 2, 2),
      MainBarPart(2, 2, 2, 2),
    ),
    BridgePart(
      "Sway Brace",
      MainBarPart(2, 2, 2, 2),
      MainBarPart(2, 2, 2, 4),
      MainBarPart(2, 2, 2, 2),
    ),
    BridgePart(
      "Stringer, button",
      MainBarPart(2, 2, 2, 2),
      MainBarPart(2, 2, 2, 2),
      MainBarPart(2, 2, 2, 2),
    ),
    BridgePart(
      "Stringer, plain",
      MainBarPart(3, 3, 3, 3),
      MainBarPart(3, 3, 3, 3),
      MainBarPart(3, 3, 3, 3),
    ),
    BridgePart(
      "Transom",
      MainBarPart(4, 4, 4, 4),
      MainBarPart(2, 2, 2, 3),
      MainBarPart(2, 2, 2, 2),
    ),
  ];
}

class MainBarPart {
  int ss;
  int ds;
  int dd;
  int dt;
  operator [](TypesOfConstruction key) => <TypesOfConstruction, int>{
        TypesOfConstruction.SS: ss,
        TypesOfConstruction.DS: ds,
        TypesOfConstruction.DD: dd,
        TypesOfConstruction.DT: dt,
      }[key];
  MainBarPart(this.ss, this.ds, this.dd, this.dt);
}
