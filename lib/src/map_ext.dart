extension MapExt<K, V> on Map<K, V> {
  Map<K, V2> mapValues<V2>(V2 Function(MapEntry<K, V>) convert) {
    final result = <K, V2>{};
    for (final entry in entries) {
      result[entry.key] = convert(entry);
    }
    return result;
  }
}
