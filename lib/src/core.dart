bool log(String tagOrMessage, [String? message, Object? exception]) {
  final msg = message == null ? tagOrMessage : "$tagOrMessage: $message";
  // wrapped by assert
  // ignore: avoid_print
  print(msg);
  if (exception != null) {
    // wrapped by assert
    // ignore: avoid_print
    print(exception);
  }
  return true;
}

Never error(String message) => throw StateError(message);

Type typeOf<T>() => T;
