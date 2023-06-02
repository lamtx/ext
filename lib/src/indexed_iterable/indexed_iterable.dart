import 'indexed_value.dart';

final class IndexedIterable<T> extends Iterable<IndexedValue<T>> {
  const IndexedIterable(this.items);

  final Iterable<T> items;

  @override
  Iterator<IndexedValue<T>> get iterator => _IndexedIterator(items.iterator);
}

class _IndexedIterator<T> implements Iterator<IndexedValue<T>> {
  _IndexedIterator(this.iterator);

  final Iterator<T> iterator;
  var _index = -1;

  @override
  IndexedValue<T> get current {
    return (index: _index, value: iterator.current);
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
