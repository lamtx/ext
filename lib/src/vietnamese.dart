class Vietnamese {
  factory Vietnamese() {
    return _instance ??= _create();
  }

  Vietnamese._(this._normal);

  static Vietnamese? _instance;

  final List<int> _normal;

  static Vietnamese _create() {
    const rawTones = [
        [ 'a', 'á', 'à', 'ả', 'ã', 'ạ', 'â', 'ấ', 'ầ', 'ẩ', 'ẫ', 'ậ', 'ă', 'ắ', 'ằ', 'ẳ', 'ẵ', 'ặ', 'Á', 'À', 'Ả', 'Ã', 'Ạ', 'Â', 'Ấ', 'Ầ', 'Ẩ', 'Ẫ', 'Ậ', 'Ă', 'Ắ', 'Ằ', 'Ẳ', 'Ẵ', 'Ặ' ],
        [ 'e', 'é', 'è', 'ẻ', 'ẽ', 'ẹ', 'ê', 'ế', 'ề', 'ể', 'ễ', 'ệ', 'É', 'È', 'Ẻ', 'Ẽ', 'Ẹ', 'Ê', 'Ế', 'Ề', 'Ể', 'Ễ', 'Ệ' ],
        [ 'i', 'í', 'ì', 'ỉ', 'ĩ', 'ị', 'Í', 'Ì', 'Ỉ', 'Ĩ', 'Ị' ],
        [ 'o', 'ó', 'ò', 'ỏ', 'õ', 'ọ', 'ô', 'ố', 'ồ', 'ổ', 'ỗ', 'ộ', 'ơ', 'ớ', 'ờ', 'ở', 'ỡ', 'ợ', 'Ó', 'Ò', 'Ỏ', 'Õ', 'Ọ', 'Ô', 'Ố', 'Ồ', 'Ổ', 'Ỗ', 'Ộ', 'Ơ', 'Ớ', 'Ờ', 'Ở', 'Ỡ', 'Ợ' ],
        [ 'u', 'ú', 'ù', 'ủ', 'ũ', 'ụ', 'ư', 'ứ', 'ừ', 'ử', 'ữ', 'ự', 'Ú', 'Ù', 'Ủ', 'Ũ', 'Ụ', 'Ư', 'Ứ', 'Ừ', 'Ử', 'Ữ', 'Ự' ],
        [ 'y', 'ý', 'ỳ', 'ỷ', 'ỹ', 'ỵ', 'Ý', 'Ỳ', 'Ỷ', 'Ỹ', 'Ỵ' ],
        [ 'd', 'đ', 'Đ' ]
    ];
    final tones = rawTones.map((f) {
      return f.map((j) {
        return j.codeUnitAt(0);
      }).toList(growable: false);
    }).toList(growable: false);

    var max = 0;

    for (final row in tones) {
      for (final value in row) {
        if (value > max) {
          max = value;
        }
      }
    }

    final normal = List.filled(max + 1, 0);
    final A = 'A'.codeUnitAt(0);
    final Z = 'Z'.codeUnitAt(0);

    for (var i = 0; i <= max; i++) {
      if (A <= i && i <= Z) {
        normal[i] = String.fromCharCode(i).toLowerCase().codeUnitAt(0);
      } else {
        normal[i] = i;
      }
    }

    int base;
    for (final tone in tones) {
      base = tone[0];
      for (var j = 1; j < tone.length; j++) {
        normal[tone[j]] = base;
      }
    }

    return Vietnamese._(normal);
  }

  String normal(String s) {
    if (s.isEmpty) {
      return s;
    }

    final builder = List.filled(s.length, 0);
    final sentence = s.codeUnits;
    var counter = 0;
    for (final c in sentence) {
      if (c >= _normal.length) {
        builder[counter++] = c;
      } else {
        builder[counter++] = _normal[c];
      }
    }
    return String.fromCharCodes(builder);
  }
}
