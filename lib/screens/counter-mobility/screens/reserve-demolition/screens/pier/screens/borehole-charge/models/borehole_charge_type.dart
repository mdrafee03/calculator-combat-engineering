class BoreholeChargeType {
  String id;
  String name;
  int row;
  BoreholeChargeType(this.id, this.name, this.row);
  static List<BoreholeChargeType> typesOfBoreholePier = [
    new BoreholeChargeType("1", "Masonry Pier up to 6' thickness", 2),
    new BoreholeChargeType(
        "2", "Masonry Pier up to 6'-9' thickness' thickness", 3),
    new BoreholeChargeType("3", "Concrete Pier up to 6' thickness", 3),
    new BoreholeChargeType("4", "Concrete Pier up to 9'-12' thickness", 3),
  ];
}
