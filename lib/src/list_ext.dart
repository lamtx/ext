import 'predicate.dart';

extension NullableListExt<T> on List<T>? {
  List<T> ifEmpty(List<T> Function() other) {
    if (this != null && isNotEmpty) {
      return this;
    }
    return other();
  }
}

extension ListExt<T> on List<T> {
  void sortBy<R extends Comparable<R>>(R Function(T) key) {
    sort((a, b) => key(a).compareTo(key(b)));
  }

  void sortDescBy<R extends Comparable<R>>(R Function(T) key) {
    sort((a, b) => -key(a).compareTo(key(b)));
  }

  Iterable<int> get indices => _IntRange(0, length - 1);

  bool updateFirst(Predicate<T> where, T Function(T) transform) {
    final index = indexWhere(where);
    if (index != -1) {
      this[index] = transform(this[index]);
    }
    return index != -1;
  }

  bool removeFirst(Predicate<T> where) {
    final index = indexWhere(where);
    if (index != -1) {
      removeAt(index);
    }
    return index != -1;
  }

  void replaceAll(T Function(T) transform) {
    for (var i = 0; i < length; i++) {
      this[i] = transform(this[i]);
    }
  }

  bool replaceValue(T e) {
    final index = indexOf(e);
    if (index != -1) {
      this[index] = e;
    }
    return index != -1;
  }

  void swap(int i, int j) {
    final temp = this[i];
    this[i] = this[j];
    this[j] = temp;
  }

  void reverse() {
    final len = length ~/ 2;
    for (var i = 0; i < len; i++) {
      swap(i, length - i - 1);
    }
  }
}

class _IntRange extends Iterable<int> {
  const _IntRange(this.start, this.end);

  final int start;
  final int end;

  @override
  Iterator<int> get iterator => _IntRangeIterator(start, end);
}

class _IntRangeIterator extends Iterator<int> {
  _IntRangeIterator(this.start, this.end) : _value = start - 1;

  final int start;
  final int end;
  int _value;

  @override
  int get current => _value;

  @override
  bool moveNext() {
    _value += 1;
    return _value <= end;
  }
}
