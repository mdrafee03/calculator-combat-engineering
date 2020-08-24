extension DoubleExtensions on double {
  double toDoubleAsPrecision() {
    return double.parse(this.toStringAsPrecision(4));
  }
}
