class Lazy<T extends Object> {
  Lazy(T Function() init) : _init = init;

  final T Function() _init;
  T? _value;

  T call() => _value ??= _init();

  bool get isInitialized => _value != null;
}
