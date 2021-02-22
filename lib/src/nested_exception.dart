class NestedException implements Exception {
  const NestedException(this.cause);

  final Object cause;

  @override
  String toString() => "Nested Exception, cause: $cause";
}
