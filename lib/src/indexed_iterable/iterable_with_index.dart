import 'indexed_iterable.dart';
import 'indexed_value.dart';

extension IterableWithIndex<T> on Iterable<T> {
  // ignore: use_to_and_as_if_applicable
  Iterable<IndexedValue<T>> withIndex() {
    return IndexedIterable(this);
  }
}