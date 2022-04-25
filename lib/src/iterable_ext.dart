import 'pair.dart';
import 'predicate.dart';

extension IterableExt<T> on Iterable<T> {
  double sumByDouble(double Function(T) transform) {
    var value = 0.0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int sumByInt(int Function(T e) transform) {
    var value = 0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int countBy(bool Function(T e) predicate) {
    var count = 0;
    for (final e in this) {
      if (predicate(e)) {
        count += 1;
      }
    }
    return count;
  }

  List<T> added(T newItem) {
    if (isEmpty) {
      return [newItem];
    }
    final list = List<T>.filled(length + 1, first);
    var i = 0;
    for (final e in this) {
      list[i++] = e;
    }
    list.last = newItem;
    return list;
  }

  T? firstOrNull([bool Function(T e)? predicate]) {
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

  T? lastOrNull([bool Function(T e)? predicate]) {
    if (predicate == null) {
      return isEmpty ? null : last;
    }
    late T result;
    var foundMatching = false;
    for (final e in this) {
      if (predicate(e)) {
        result = e;
        foundMatching = true;
      }
    }
    return foundMatching ? result : null;
  }

  Map<K, V> associate<K, V>(Pair<K, V> Function(T e) transform) {
    final result = <K, V>{};
    for (final e in this) {
      final r = transform(e);
      result[r.first] = r.second;
    }
    return result;
  }

  Map<K, T> associateBy<K>(K Function(T e) selector) {
    final result = <K, T>{};
    for (final e in this) {
      result[selector(e)] = e;
    }
    return result;
  }

  List<R> flatten<R>(List<R> Function(T element) transform) {
    final result = <R>[];
    for (final element in this) {
      result.addAll(transform(element));
    }
    return result;
  }

  List<R> mapNotNull<R>(R? Function(T e) transform) {
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

  List<T> filter(Predicate<T> predicate) {
    final result = <T>[];
    for (final e in this) {
      if (predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  List<T> filterNot(Predicate<T> predicate) {
    final result = <T>[];
    for (final e in this) {
      if (!predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  List<R> mapToList<R>(R Function(T) transform) {
    return map(transform).toList();
  }

  Iterable<T> whereIf(bool value, Predicate<T> predicate) =>
      value ? where(predicate) : this;

  String joinToString([
    String? separator = ", ",
    String Function(T e)? transform,
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

  Map<R, List<T>> groupBy<R>(R Function(T element) key) {
    final map = <R, List<T>>{};
    for (final element in this) {
      final list = map.putIfAbsent(key(element), () => []);
      list.add(element);
    }
    return map;
  }

  T? maxBy<R extends Comparable<R>>(R Function(T element) selector) {
    if (isEmpty) {
      return null;
    }
    var value = selector(first);
    T? element;
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
