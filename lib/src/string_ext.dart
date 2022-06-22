import 'predicate.dart';

extension NullableStringExt on String? {
  String ifEmpty(String Function() other) {
    if (this != null && this!.isNotEmpty) {
      return this!;
    }
    return other();
  }

  String orEmpty() => this ?? "";
}

extension StringExt on String {
  String? takeNotEmpty() => isEmpty ? null : this;

  int? toIntOrNull() => int.tryParse(this);

  String substringBeforeLast(String delimiter,
      [String? missingDelimiterValue]) {
    final index = lastIndexOf(delimiter);
    if (index == -1) {
      return missingDelimiterValue ?? this;
    } else {
      return substring(0, index);
    }
  }

  String substringAfterLast(String delimiter, [String? missingDelimiterValue]) {
    final index = lastIndexOf(delimiter);
    if (index == -1) {
      return missingDelimiterValue ?? this;
    } else {
      return substring(index + delimiter.length, length);
    }
  }

  String get extension => substringAfterLast(".", "");

  String get nameWithoutExtension => substringBeforeLast(".");

  String removeAll(Iterable<int> characters) {
    final sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      final char = codeUnitAt(i);
      if (!characters.contains(char)) {
        sb.writeCharCode(char);
      }
    }
    return sb.toString();
  }

  String removeChar(int character) {
    final sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      final char = codeUnitAt(i);
      if (char != character) {
        sb.writeCharCode(char);
      }
    }
    return sb.toString();
  }

  bool all(Predicate<int> predicate) {
    for (var i = 0; i < length; i++) {
      if (!predicate(codeUnitAt(i))) {
        return false;
      }
    }
    return true;
  }
}
