import 'dart:collection';

class LinkedListEntry<E> {
  LinkedListEntry._(
    E value, {
    LinkedListEntry<E>? prev,
    LinkedListEntry<E>? next,
  })  : _value = value,
        _prev = prev,
        _next = next;

  final E _value;
  LinkedListEntry<E>? _prev;
  LinkedListEntry<E>? _next;
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(this.node);

  LinkedListEntry<E>? node;
  E? _current;

  @override
  E get current => _current ?? (throw StateError("No elements"));

  @override
  bool moveNext() {
    if (node == null) {
      return false;
    }
    _current = node!._value;
    node = node!._next;
    return true;
  }
}

class LinkedList<E> with IterableMixin<E> implements Iterable<E> {
  LinkedList();

  LinkedList.of(Iterable<E> source) {
    source.forEach(add);
  }

  LinkedListEntry<E>? _front;
  LinkedListEntry<E>? _rear;
  int _length = 0;

  @override
  String toString() {
    return IterableBase.iterableToFullString(this);
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(_front);

  @override
  int get length => _length;

  @override
  bool get isEmpty => _length == 0;

  @override
  E get first => _front?._value ?? (throw StateError("No elements"));

  @override
  E get last => _rear?._value ?? (throw StateError("No elements"));

  void add(E value) {
    if (isEmpty) {
      final entry = LinkedListEntry._(value);
      _front = entry;
      _rear = entry;
      _length = 1;
    } else {
      final entry = LinkedListEntry._(value, prev: _rear);
      _rear!._next = entry;
      _rear = entry;
      _length += 1;
    }
  }

  void addFirst(E value) {
    if (isEmpty) {
      final entry = LinkedListEntry._(value);
      _front = entry;
      _rear = entry;
      _length = 1;
    } else {
      final entry = LinkedListEntry._(value, next: _front);
      _front!._prev = entry;
      _front = entry;
      _length += 1;
    }
  }

  E? removeFirst() {
    if (isEmpty) {
      return null;
    }
    final value = _front!._value;
    if (_front!._next == null) {
      _front = null;
      _rear = null;
      _length = 0;
    } else {
      _front!._next!._prev = null;
      _front = _front!._next;
      _length -= 1;
    }
    return value;
  }

  E? removeLast() {
    if (isEmpty) {
      return null;
    }
    final value = _rear!._value;
    if (_rear!._prev == null) {
      _front = null;
      _rear = null;
      _length = 0;
    } else {
      _rear!._prev!._next = null;
      _rear = _rear!._prev;
      _length -= 1;
    }
    return value;
  }

  void removeNode(LinkedListEntry<E> node) {
    if (node._next != null) {
      node._next!._prev = node._prev;
    } else {
      _rear = node._prev;
    }
    if (node._prev != null) {
      node._prev!._next = node._next;
    } else {
      _front = node._next;
    }
    _length -= 1;
  }

  E? removeWhere(bool Function(E) predicate) {
    for (var node = _front; node != null; node = node._next) {
      if (predicate(node._value)) {
        removeNode(node);
        return node._value;
      }
    }

    return null;
  }

  List<E> removeAll(bool Function(E) predicate) {
    final result = <E>[];

    for (var node = _front; node != null; node = node._next) {
      if (predicate(node._value)) {
        removeNode(node);
        result.add(node._value);
      }
    }

    return result;
  }

  void clear() {
    _length = 0;
    _front = null;
    _rear = null;
  }
}
