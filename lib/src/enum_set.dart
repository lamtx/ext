// import 'dart:collection';
//
// class EnumSet<T> with SetMixin<T> implements Set<T> {
//   EnumSet.noneOf(List<T> values) : this.bits(values, 0);
//
//   EnumSet.bits(List<T> values, int bits)
//       : assert(_verify(values, bits)),
//         _values = values,
//         _value = bits;
//
//   EnumSet.allOf(List<T> values) : this.bits(values, ~((-1) << (values.length)));
//
//   int _value;
//   final List<T> _values;
//
//   int get bits => _value;
//
//   @override
//   bool add(T value) {
//     _value = _value | (1 << indexOf(value));
//     return true;
//   }
//
//   @override
//   bool contains(Object? element) {
//     return _value & (1 << indexOf(element)) != 0;
//   }
//
//   @override
//   bool get isEmpty => _value == 0;
//
//   @override
//   Iterator<T> get iterator => _EnumSetIterator(this);
//
//   @override
//   int get length => bitCount(_value);
//
//   @override
//   T? lookup(Object? element) {
//     if (contains(element)) {
//       return element as T;
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   bool remove(Object? value) {
//     _value = _value & ~(1 << indexOf(value));
//     return true;
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (other is EnumSet<T>) {
//       return other._value == _value;
//     }
//     if (other is Set<T>) {
//       if (length != other.length) {
//         return false;
//       }
//       for (final e in other) {
//         if (!contains(e)) {
//           return false;
//         }
//       }
//       return true;
//     }
//     return false;
//   }
//
//   @override
//   EnumSet<T> toSet() {
//     return EnumSet.bits(_values, _value);
//   }
//
//   static int indexOf(Object? value) {
//     final dynamic d = value;
//     try {
//       return d.index as int;
//       // ignore: avoid_catching_errors
//     } on NoSuchMethodError {
//       throw ArgumentError("$value is not a enum");
//     }
//   }
//
//   static int bitCount(int value) {
//     // HD, Figure 5-14
//     var i = value;
//     i = i - ((i >> 1) & 0x5555555555555555);
//     i = (i & 0x3333333333333333) + ((i >> 2) & 0x3333333333333333);
//     i = (i + (i >> 4)) & 0x0f0f0f0f0f0f0f0f;
//     i = i + (i >> 8);
//     i = i + (i >> 16);
//     i = i + (i >> 32);
//     return i & 0x7f;
//   }
//
//   static bool _verify<T>(List<T> values, int bits) {
//     final shifted = -1 << (values.length);
//     return (bits & shifted) == 0;
//   }
// }
//
// // Testing purpose only, unoptimized
// class _EnumSetIterator<T> extends Iterator<T> {
//   _EnumSetIterator(this.source);
//
//   final EnumSet<T> source;
//   var _index = -1;
//
//   @override
//   T get current {
//     final value = source._values[_index];
//     if (source.contains(value)) {
//       return value;
//     }
//     throw IndexError(_index, source);
//   }
//
//   @override
//   bool moveNext() {
//     _index += 1;
//     while (_index < source._values.length) {
//       if (source.contains(source._values[_index])) {
//         return true;
//       }
//       _index += 1;
//     }
//     return false;
//   }
// }
