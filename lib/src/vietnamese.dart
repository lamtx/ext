class Vietnamese {
  factory Vietnamese() {
    return _instance ??= _create();
  }

  Vietnamese._(this._normal);

  static Vietnamese? _instance;

  final List<int> _normal;

  static Vietnamese _create() {
    const rawTones = [
      "aáàȧâäǎăāãåąⱥǡǻǟȁȃḁæǽǣÁÀȦÂÄǍĂĀÃÅĄȺǠǺǞȀȂḀÆǼǢảạấầẩẫậắằẳẵặẢẠẤẦẨẪẬẮẰẲẴẶ",
      "eéèėêëěĕēęȩɇḗḕḝȅȇḙḛÈĖÊËĚĔĒĘȨɆḖḔḜȄȆḘḚẻẽẹếềểễệÉẺẼẸẾỀỂỄỆ",
      "iíìıîïǐĭīĩįḯȉȋḭÍÌİÎÏǏĬĪĨĮḮȈȊḬỉịỈỊ",
      "oóòȯôöǒŏōõǫőøṓṑṍȱȫṏǿȭǭȍȏœÓÒȮÔÖǑŎŌÕǪŐØṒṐṌȰȪṎǾȬǬȌȎŒỏọốồổỗộơớờởỡợỎỌỐỒỔỖỘƠỚỜỞỠỢ",
      "uúùûüǔŭūũůųűʉǘǜṹǚṻǖȕȗṳṷṵÚÙÛÜǓŬŪŨŮŲŰɄǗǛṸǙṺǕȔȖṲṶṴủụưứừửữựỦỤƯỨỪỬỮỰ",
      "bḃƀḅḇḂɃḄḆ",
      "cćċĉčçȼḉĆĊĈČÇȻḈ",
      "dḋďḑđḍḓḏðḊĎḐĐḌḒḎÐ",
      "fḟḞ",
      "gǵġĝǧğḡģǥǴĠĜǦĞḠĢǤ",
      "hḣĥḧȟḩħḥḫⱨḢĤḦȞḨĦḤḪⱧ",
      "jĵɉĴɈ",
      "kḱǩķḳḵⱪḰǨĶḲḴⱩ",
      "lĺŀľļƚłḷḽḻḹĹĿĽĻȽŁḶḼḺḸ",
      "mḿṁṃḾṀṂ",
      "nńǹṅňñņƞṇṋṉŋŃǸṄŇÑŅȠṆṊṈŊ",
      "pṕṗṔṖ",
      "qɋɊ",
      "rŕṙřŗɍȑȓṛṟṝŔṘŘŖɌȐȒṚṞṜ",
      "sśṡŝšşṥṧṣșṩßŚṠŜŠŞṤṦṢȘṨẞ",
      "tṫťţṭțṱṯⱦþŧṪŤŢṬȚṰṮȾÞŦ",
      "vṽṿṼṾ",
      "wẃẁẇŵẅẉⱳẂẀẆŴẄẈⱲ",
      "xẋẍẊẌ",
      "yýỳẏŷÿȳỹɏỷỵÝỲẎŶŸȲỸɎỶỴ",
      "zźżẑžȥẓẕⱬŹŻẐŽȤẒẔⱫ",
    ];
    final tones = rawTones.map((f) {
      assert(f.length == f.codeUnits.length);
      return f.codeUnits;
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
    const A = 0x41;
    const Z = 0x5A;
    assert(A == 'A'.codeUnitAt(0) && Z == 'Z'.codeUnitAt(0));
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
