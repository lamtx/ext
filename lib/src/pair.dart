class Pair<T, S> {
  const Pair(this.first, this.second);

  final T first;
  final S second;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair && first == other.first && second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
