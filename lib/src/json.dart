import 'dart:convert';

typedef JsonObjectFactory<T> = T Function(Map<String, Object>);

abstract interface class ToJson {
  Object? toJson();
}

extension JsonToObject<T> on JsonObjectFactory<T> {
  T parseObject(String s) {
    final dynamic map = json.decode(s);
    if (map is Map) {
      return this(map.cast());
    } else {
      throw Exception("The provided json is not a map.");
    }
  }

  List<T> parseList(String s) {
    final dynamic array = json.decode(s);
    if (array is List) {
      return array
          .whereType<Map<dynamic, dynamic>>()
          .map((e) => this(e.cast()))
          .toList();
    } else {
      throw Exception("The provided json is not a list.");
    }
  }
}

extension SerializableJsonObject on ToJson {
  String serializeAsJson() {
    return json.encode(toJson());
  }

  String serializeAsUrlEncoded() {
    final json = toJson();
    if (json is Map<String, Object?>) {
      return _toUrlEncoded(json);
    } else {
      throw ArgumentError(
        "The `toJson` method of $runtimeType has to return to `Map<String, Object?>`",
      );
    }
  }
}

extension SerializableJsonListObject on List<ToJson?> {
  List<Object?> toJson() {
    return map((e) => e?.toJson()).toList(growable: false);
  }

  String serializeAsJson() {
    return json.encode(toJson());
  }
}

String _toUrlEncoded(Map<String, Object?> params) {
  final s = StringBuffer();
  params.forEach((key, value) {
    if (value == null) {
      return;
    }
    if (value is ToJson) {
      value = value.toJson();
    }
    String sValue;
    if (value is String) {
      if (value.isEmpty) {
        return;
      }
      sValue = value;
    } else if (value is num) {
      sValue = value.toString();
    } else if (value is bool) {
      sValue = value.toString();
    } else if (value is DateTime) {
      sValue = value.toUtc().toIso8601String();
    } else if (value is Enum) {
      sValue = value.index.toString();
    } else {
      throw UnsupportedError("Unsupported parameter type ${value.runtimeType}");
    }

    if (s.isNotEmpty) {
      s.write("&");
    }
    s
      ..write(Uri.encodeComponent(key))
      ..write("=")
      ..write(Uri.encodeComponent(sValue));
  });
  return s.toString();
}
