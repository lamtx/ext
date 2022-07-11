extension OperatorOnComparator<T extends Comparable<T>> on T {
  bool operator >(T other) {
    return compareTo(other) > 0;
  }

  bool operator >=(T other) {
    return compareTo(other) >= 0;
  }

  bool operator <(T other) {
    return compareTo(other) < 0;
  }

  bool operator <=(T other) {
    return compareTo(other) <= 0;
  }
}

extension CoerceComparator<T extends Comparable<T>> on T {
  T coerceIn(T minimumValue, T maximumValue) {
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

  T coerceAtMost(T maximumValue) {
    return this > maximumValue ? maximumValue : this;
  }

  T coerceAtLeast(T minimumValue) {
    return this < minimumValue ? minimumValue : this;
  }
}
