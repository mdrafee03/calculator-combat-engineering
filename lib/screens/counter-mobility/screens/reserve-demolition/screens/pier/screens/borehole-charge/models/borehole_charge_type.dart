class BoreholeChargeType {
  String id;
  String name;
  int row;
  BoreholeChargeType(this.id, this.name, this.row);
  static List<BoreholeChargeType> typesOfBoreholePier = [
    BoreholeChargeType("1", "Masonry Pier up to 6' thickness", 2),
    BoreholeChargeType("2", "Masonry Pier up to 6'-9' thickness' thickness", 3),
    BoreholeChargeType("3", "Concrete Pier up to 6' thickness", 3),
    BoreholeChargeType("4", "Concrete Pier up to 9'-12' thickness", 3),
  ];
}
