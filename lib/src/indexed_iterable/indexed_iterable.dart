import 'indexed_value.dart';

class IndexedIterable<T> extends Iterable<IndexedValue<T>> {
  const IndexedIterable(this.items);

  final Iterable<T> items;

  @override
  Iterator<IndexedValue<T>> get iterator => _IndexedIterator(items.iterator);
}

class _IndexedIterator<T> extends Iterator<IndexedValue<T>> {
  _IndexedIterator(this.iterator);

  final Iterator<T> iterator;
  var _index = -1;

  @override
  IndexedValue<T> get current {
    return IndexedValue(_index, iterator.current);
  }

  @override
  bool moveNext() {
    if (iterator.moveNext()) {
      _index += 1;
      return true;
    }
    return false;
  }
}
