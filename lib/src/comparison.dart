typedef CompareSelector<T> = Comparable<Object>? Function(T e);

Comparator<T> compareBy<T>(CompareSelector<T> selector,
    [CompareSelector<T>? thenBySelector]) {
  if (thenBySelector != null) {
    return _compareByMultiple([selector, thenBySelector]);
  }
  return (a, b) => _compare(selector(a), selector(b));
}

Comparator<T> compareByDescending<T>(CompareSelector<T> selector) {
  return (a, b) => _compare(selector(b), selector(a));
}

Comparator<T> _compareByMultiple<T>(List<CompareSelector<T>> selectors) {
  return (a, b) {
    for (final fn in selectors) {
      final v1 = fn(a);
      final v2 = fn(b);
      final diff = _compare(v1, v2);
      if (diff != 0) {
        return diff;
      }
    }
    return 0;
  };
}

int _compare(Comparable<Object?>? a, Comparable<Object?>? b) {
  if (identical(a, b)) {
    return 0;
  }
  if (a == null) {
    return -1;
  }
  if (b == null) {
    return 1;
  }

  return a.compareTo(b);
}

extension ComparatorExt<T> on Comparator<T> {
  Comparator<T> thenBy(Comparable<void> Function(T e) selector) {
    return (a, b) {
      final previous = this.call(a, b);
      return previous == 0 ? _compare(selector(a), selector(b)) : previous;
    };
  }
}
