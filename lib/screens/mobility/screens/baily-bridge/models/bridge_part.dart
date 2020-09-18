import '../models/baily_bridge.dart';

class BridgePart {
  String name;
  MainBarPart head;
  MainBarPart intermediate;
  MainBarPart tail;
  BridgePart(this.name, this.head, this.intermediate, this.tail);
  static List<BridgePart> listOfBridgePart = [
    new BridgePart(
      "Baseplate",
      new MainBarPart(2, 2, 2, 2),
      new MainBarPart(0, 0, 0, 0),
      new MainBarPart(2, 2, 2, 2),
    ),
    new BridgePart(
      "Footwalk",
      new MainBarPart(6, 6, 6, 6),
      new MainBarPart(4, 4, 4, 4),
      new MainBarPart(4, 4, 4, 4),
    ),
    new BridgePart(
      "Panel",
      new MainBarPart(2, 4, 8, 8),
      new MainBarPart(2, 4, 8, 12),
      new MainBarPart(2, 4, 8, 8),
    ),
    new BridgePart(
      "End post",
      new MainBarPart(2, 4, 4, 4),
      new MainBarPart(0, 0, 0, 0),
      new MainBarPart(2, 4, 4, 4),
    ),
    new BridgePart(
      "Raker",
      new MainBarPart(4, 4, 4, 4),
      new MainBarPart(2, 2, 2, 2),
      new MainBarPart(2, 2, 2, 2),
    ),
    new BridgePart(
      "Sway Brace",
      new MainBarPart(2, 2, 2, 2),
      new MainBarPart(2, 2, 2, 4),
      new MainBarPart(2, 2, 2, 2),
    ),
    new BridgePart(
      "Stringer, button",
      new MainBarPart(2, 2, 2, 2),
      new MainBarPart(2, 2, 2, 2),
      new MainBarPart(2, 2, 2, 2),
    ),
    new BridgePart(
      "Stringer, plain",
      new MainBarPart(3, 3, 3, 3),
      new MainBarPart(3, 3, 3, 3),
      new MainBarPart(3, 3, 3, 3),
    ),
    new BridgePart(
      "Transom",
      new MainBarPart(4, 4, 4, 4),
      new MainBarPart(2, 2, 2, 3),
      new MainBarPart(2, 2, 2, 2),
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
