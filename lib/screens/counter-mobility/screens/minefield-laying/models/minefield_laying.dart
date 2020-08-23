import 'package:fraction/fraction.dart';

class MinefieldLaying {
  final Fraction standardDensity = Fraction.fromDouble(1 / 3);
  Fraction frontage;
  Fraction density;
  int get numberOfStrips {
    return (density / standardDensity).toDouble().ceil();
  }

  int get numberOfClusterPerStrip {
    return (frontage * standardDensity).toDouble().ceil();
  }

  Fraction convertToFraction(String val) {
    return double.tryParse(val) != null
        ? Fraction.fromDouble(double.parse(val))
        : Fraction.fromString(val);
  }
}
