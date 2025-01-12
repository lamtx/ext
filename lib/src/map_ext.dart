extension MapExt<K, V> on Map<K, V> {
  Map<K, V2> mapValues<V2>(V2 Function(V) convert) {
    final result = <K, V2>{};
    for (final key in keys) {
      result[key] = convert(this[key] as V);
    }
    return result;
  }
}
