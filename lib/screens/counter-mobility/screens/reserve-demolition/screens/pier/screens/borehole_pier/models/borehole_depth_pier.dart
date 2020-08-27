class BoreHoleDepthPier {
  List<int> range;
  double dia;
  double length;
  BoreHoleDepthPier(this.range, this.dia, this.length);
}

List<BoreHoleDepthPier> typesOfBoreHoleDepthPier = [
  new BoreHoleDepthPier([0, 40], 2, 6),
  new BoreHoleDepthPier([40, 60], 1.75, 8),
  new BoreHoleDepthPier([60, 72], 1.5, 10.5),
];
