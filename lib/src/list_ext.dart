import 'dart:collection';

import 'predicate.dart';

extension NullableListExt<T> on List<T>? {
  List<T> ifEmpty(List<T> Function() other) {
    if (this != null && this!.isNotEmpty) {
      return this!;
    }
    return other();
  }
}

extension ListExt<T> on List<T> {
  Iterable<int> get indices => _IntRange(0, length - 1);

  bool updateFirst(Predicate<T> where, T Function(T e) transform) {
    final index = indexWhere(where);
    if (index != -1) {
      this[index] = transform(this[index]);
    }
    return index != -1;
  }

  bool updateAll(Predicate<T> where, T Function(T e) transform) {
    var changed = false;
    for (var i = 0; i < length; i++) {
      final element = this[i];
      if (where(element)) {
        changed = true;
        this[i] = transform(element);
      }
    }
    return changed;
  }

  bool removeFirst(Predicate<T> where) {
    final index = indexWhere(where);
    if (index != -1) {
      removeAt(index);
    }
    return index != -1;
  }

  void replaceAll(T Function(T e) transform) {
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

  List<T> get reversedList => _ReversedList(this);
}

class _IntRange extends Iterable<int> {
  const _IntRange(this.start, this.end);

  final int start;
  final int end;

  @override
  Iterator<int> get iterator => _IntRangeIterator(start, end);
}

class _IntRangeIterator implements Iterator<int> {
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

final class _ReversedList<E> with ListBase<E> implements List<E> {
  _ReversedList(this._base);

  final List<E> _base;

  @override
  int get length => _base.length;

  @override
  set length(int value) => _base.length = value;

  @override
  E operator [](int index) => _base[_base.length - index - 1];

  @override
  void operator []=(int index, E value) {
    _base[_base.length - index - 1] = value;
  }
}
