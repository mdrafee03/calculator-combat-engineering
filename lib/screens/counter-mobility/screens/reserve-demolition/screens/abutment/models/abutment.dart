import 'dart:math';

import '../../summary/models/reserve_demolition_summary.dart';

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
    double charge = n * weightOfCharges(n);
    ReserveDemolitionSummary.abutmentCharge = charge;
    return charge;
  }

  List<double> distanceFromFace(int n) {
    return [craterDia(n) / 2, craterDia(n) / 4];
  }

  double spacingOfCharges(int n) {
    return n == 1 ? 0 : 2 * craterDia(n) / 3;
  }

  double get timeRequiredPerSection {
    return 2 * craterNo / 3;
  }

  double get timeRequiredByPlatoon {
    double time =
        (timeRequiredPerSection / 4) >= 1 ? (timeRequiredPerSection / 4) : 1;
    ReserveDemolitionSummary.abutmentTime = time;
    return time;
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
