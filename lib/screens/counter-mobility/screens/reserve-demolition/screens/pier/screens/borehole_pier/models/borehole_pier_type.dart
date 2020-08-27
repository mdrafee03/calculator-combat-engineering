class BoreholePierType {
  String name;
  int row;
  bool isBoth;
  BoreholePierType(this.name, this.row, this.isBoth);
}

List<BoreholePierType> typesOfBoreholePier = [
  new BoreholePierType("Masonry Pier up to 6' thickness", 2, false),
  new BoreholePierType(
      "Masonry Pier up to 6'-9' thickness' thickness", 3, false),
  new BoreholePierType("Concrete Pier up to 6' thickness", 3, false),
  new BoreholePierType("Concrete Pier up to 9'-12' thickness", 3, true),
];
