import 'dart:math';

class Abutment {
  double width;
  double targetFactor;
  int craterNo;
  double craterDia(int n) {
    if (n == 1) {
      return width;
    } else {
      return (width + width / 3) / n;
    }
  }

  double weightOfCharges(int n) {
    return pow(craterDia(n), 3) / targetFactor;
  }

  double totalExclusive(int n) {
    return n * weightOfCharges(n);
  }

  List<double> distanceFromFace(int n) {
    return [craterDia(n) / 2, craterDia(n) / 4];
  }

  double spacingOfCharges(int n) {
    return 2 * craterDia(n) / 3;
  }

  List<double> chargesDepth(int n) {
    return [3 * distanceFromFace(n)[0] / 2, 3 * distanceFromFace(n)[1] / 2];
  }
}

List<Map<String, dynamic>> typesOfTarget = [
  {"type": "Masonry Abutment", "value": 50},
  {"type": "Roads/Medium and Hard soil", "value": 100},
  {"type": "Soft soil", "value": 200},
];
