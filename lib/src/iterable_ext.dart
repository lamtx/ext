import 'predicate.dart';

extension IterableExt<E> on Iterable<E> {
  double sumOfDouble(double Function(E e) transform) {
    var value = 0.0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int sumOfInt(int Function(E e) transform) {
    var value = 0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int count([bool Function(E e)? predicate]) {
    if (predicate == null) {
      if (this is List) {
        return length;
      } else {
        var count = 0;
        final iterator = this.iterator;
        while (iterator.moveNext()) {
          count += 1;
        }
        return count;
      }
    } else {
      var count = 0;
      for (final e in this) {
        if (predicate(e)) {
          count += 1;
        }
      }
      return count;
    }
  }

  List<E> added(E newItem) {
    if (isEmpty) {
      return [newItem];
    }
    final list = List<E>.filled(length + 1, first);
    var i = 0;
    for (final e in this) {
      list[i++] = e;
    }
    list.last = newItem;
    return list;
  }

  E? firstOrNull([bool Function(E e)? predicate]) {
    if (predicate == null) {
      return isEmpty ? null : first;
    }
    for (final e in this) {
      if (predicate(e)) {
        return e;
      }
    }
    return null;
  }

  E? lastOrNull([bool Function(E e)? predicate]) {
    if (predicate == null) {
      return isEmpty ? null : last;
    }
    late E result;
    var foundMatching = false;
    for (final e in this) {
      if (predicate(e)) {
        result = e;
        foundMatching = true;
      }
    }
    return foundMatching ? result : null;
  }

  Map<K, V> associate<K, V>((K, V) Function(E e) transform) {
    final result = <K, V>{};
    for (final e in this) {
      final r = transform(e);
      result[r.$1] = r.$2;
    }
    return result;
  }

  Map<K, E> associateBy<K>(K Function(E e) selector) {
    final result = <K, E>{};
    for (final e in this) {
      result[selector(e)] = e;
    }
    return result;
  }

  List<R> flatten<R>(List<R> Function(E element) transform) {
    final result = <R>[];
    for (final element in this) {
      result.addAll(transform(element));
    }
    return result;
  }

  List<R> mapNotNull<R>(R? Function(E e) transform) {
    final result = <R>[];
    for (final e in this) {
      final t = transform(e);
      if (t != null) {
        result.add(t);
      }
    }
    return result;
  }

  List<R> filterIsInstance<R>() {
    final result = <R>[];
    for (final e in this) {
      if (e is R) {
        result.add(e);
      }
    }
    return result;
  }

  List<E> filter(Predicate<E> predicate) {
    final result = <E>[];
    for (final e in this) {
      if (predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  List<E> filterNot(Predicate<E> predicate) {
    final result = <E>[];
    for (final e in this) {
      if (!predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  List<R> mapToList<R>(R Function(E e) transform) {
    return map(transform).toList();
  }

  Iterable<E> whereIf(bool value, Predicate<E> predicate) =>
      value ? where(predicate) : this;

  String joinToString([
    String? separator = ", ",
    String Function(E e)? transform,
  ]) {
    final iterator = this.iterator;
    transform ??= (e) => e.toString();
    if (!iterator.moveNext()) {
      return "";
    }
    final buffer = StringBuffer();
    if (separator == null || separator == "") {
      do {
        buffer.write(transform(iterator.current));
      } while (iterator.moveNext());
    } else {
      buffer.write(transform(iterator.current));
      while (iterator.moveNext()) {
        buffer.write(separator);
        buffer.write(transform(iterator.current));
      }
    }
    return buffer.toString();
  }

  Map<R, List<E>> groupBy<R>(R Function(E e) key) {
    final map = <R, List<E>>{};
    for (final element in this) {
      final list = map.putIfAbsent(key(element), () => []);
      list.add(element);
    }
    return map;
  }

  E? maxBy<R extends Comparable<R>>(R Function(E e) selector) {
    if (isEmpty) {
      return null;
    }
    var value = selector(first);
    E? element = first;
    for (final e in this) {
      final tmp = selector(e);
      if (tmp.compareTo(value) > 0) {
        value = tmp;
        element = e;
      }
    }
    return element;
  }
}

extension NonnullIterableExt<T extends Object> on Iterable<T?> {
  List<T> filterNotNull() {
    final result = <T>[];
    for (final e in this) {
      if (e != null) {
        result.add(e);
      }
    }
    return result;
  }
}
