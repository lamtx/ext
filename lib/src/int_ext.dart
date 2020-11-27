extension IntExt on int {
  int coerceIn(int minimumValue, int maximumValue) {
    if (minimumValue > maximumValue) {
      throw ArgumentError(
          "Cannot coerce value to an empty range: maximum $maximumValue is less than minimum $minimumValue.");
    }
    if (this < minimumValue) {
      return minimumValue;
    }
    if (this > maximumValue) {
      return maximumValue;
    }
    return this;
  }

  int coerceAtMost(int maximumValue) {
    return this > maximumValue ? maximumValue : this;
  }

  int coerceAtLeast(int minimumValue) {
    return this < minimumValue ? minimumValue : this;
  }

  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  T? toEnum<T>(List<T> values) {
    if (this < 0 || this > values.length) {
      return null;
    }
    return values[this];
  }

  bool get isDigit => 0x30 <= this && this <= 0x39;
}

extension DoubleExt on double {
  double coerceIn(double minimumValue, double maximumValue) {
    if (minimumValue > maximumValue) {
      throw ArgumentError(
          "Cannot coerce value to an empty range: maximum $maximumValue is less than minimum $minimumValue.");
    }
    if (this < minimumValue) {
      return minimumValue;
    }
    if (this > maximumValue) {
      return maximumValue;
    }
    return this;
  }

  double coerceAtMost(double maximumValue) {
    return this > maximumValue ? maximumValue : this;
  }

  double coerceAtLeast(double minimumValue) {
    return this < minimumValue ? minimumValue : this;
  }
}
