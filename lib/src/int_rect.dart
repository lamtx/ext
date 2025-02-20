import '../ext.dart';

final class IntRect implements ToJson {
  IntRect(this.x, this.y, this.width, this.height)
      : assert(width >= 0),
        assert(height >= 0);

  factory IntRect.fromJson(Map<String, Object?> json) => IntRect(
        (json['x']! as num).toInt(),
        (json['y']! as num).toInt(),
        (json['width']! as num).toInt(),
        (json['height']! as num).toInt(),
      );

  final int x;
  final int y;
  final int width;
  final int height;

  /// Exclusive right
  int get right => x + width;

  /// Exclusive bottom
  int get bottom => y + height;

  double get centerX => x + width / 2;

  double get centerY => y + height / 2;

  double get avgRadius => (width + height) / 4;

  IntSize get size => IntSize(width, height);

  IntOffset get offset => IntOffset(x, y);

  int get area => width * height;

  bool get isEmpty => width == 0 || height == 0;

  IntRect operator +(IntOffset offset) =>
      IntRect(x + offset.x, y + offset.y, width, height);

  IntRect operator -(IntOffset offset) =>
      IntRect(x - offset.x, y - offset.y, width, height);

  bool contains(IntRect other, {bool inclusive = false}) {
    return inclusive
        ? x <= other.x &&
            other.right <= right &&
            y <= other.y &&
            other.bottom <= bottom
        : x < other.x &&
            other.right < right &&
            y < other.y &&
            other.bottom < bottom;
  }

  @override
  String toString() => "Rect[($x, $y) ${width}x$height]";

  @override
  Map<String, Object> toJson() => {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
      };
}
