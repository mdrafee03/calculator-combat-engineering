class BoreholePierType {
  String id;
  String name;
  int row;
  BoreholePierType(this.id, this.name, this.row);
}

List<BoreholePierType> typesOfBoreholePier = [
  new BoreholePierType("1", "Masonry Pier up to 6' thickness", 2),
  new BoreholePierType("2", "Masonry Pier up to 6'-9' thickness' thickness", 3),
  new BoreholePierType("3", "Concrete Pier up to 6' thickness", 3),
  new BoreholePierType("4", "Concrete Pier up to 9'-12' thickness", 3),
];
