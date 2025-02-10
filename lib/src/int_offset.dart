import 'json.dart';

final class IntOffset implements ToJson {
  const IntOffset(this.x, this.y);

  factory IntOffset.fromJson(Map<String, Object?> json) => IntOffset(
        (json['x']! as num).toInt(),
        (json['y']! as num).toInt(),
      );

  final int x;
  final int y;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntOffset && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Offset($x,$y)';

  @override
  Map<String, Object?> toJson() => {
        'x': x,
        'y': y,
      };

  static const zero = IntOffset(0, 0);
}
