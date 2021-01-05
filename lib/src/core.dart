import 'predicate.dart';

extension Core<T> on T {
  T? takeIf(Predicate<T> predicate) => predicate(this) ? this : null;

  R run<R>(R Function(T) block) => block(this);

  T also(void Function(T) block) {
    block(this);
    return this;
  }
}

bool log(String tagOrMessage, [String? message, Object? exception]) {
  final msg = message == null ? tagOrMessage : "$tagOrMessage: $message";
  // ignore: avoid_print
  print(msg);
  if (exception != null) {
    // ignore: avoid_print
    print(exception);
  }
  return true;
}

Never error(String message) => throw StateError(message);

Type typeOf<T>() => T;
