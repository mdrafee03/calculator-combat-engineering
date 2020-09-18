class LaidAnchorHPB {
  double current;
  int type;
  double upstream;
  double downstream;
  LaidAnchorHPB(this.current, this.type, this.upstream, this.downstream);

  static List<LaidAnchorHPB> listOfLaidAnchor = [
    LaidAnchorHPB(0.5, 1, 1 / 6, 1 / 6),
    LaidAnchorHPB(1.0, 1, 1 / 6, 1 / 6),
    LaidAnchorHPB(1.5, 1, 1 / 4, 1 / 6),
    LaidAnchorHPB(2.0, 1, 1 / 3, 1 / 6),
    LaidAnchorHPB(0.5, 2, 1 / 3, 1 / 3),
    LaidAnchorHPB(1.0, 2, 1 / 3, 1 / 3),
    LaidAnchorHPB(1.5, 2, 1 / 3, 1 / 3),
    LaidAnchorHPB(2.0, 2, 1 / 2, 1 / 2),
    LaidAnchorHPB(2.5, 2, 1 / 2, 1 / 2),
  ];
}
