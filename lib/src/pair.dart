import 'dart:ui';

class Pair<T, S> {
  const Pair(this.first, this.second);

  final T first;
  final S second;

  @override
  bool operator ==(Object other) =>
      other is Pair<T, S> && other.first == first && other.second == second;

  @override
  int get hashCode => hashValues(first, second);
}
