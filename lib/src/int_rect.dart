import 'json.dart';

final class IntRect implements ToJson {
  IntRect(this.x, this.y, this.width, this.height)
      : assert(x >= 0),
        assert(y >= 0),
        assert(width > 0),
        assert(height > 0);

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

  int get right => x + width - 1;

  int get bottom => y + height - 1;

  double get centerX => x + width / 2;

  double get centerY => y + height / 2;

  double get avgRadius => (width + height) / 4;

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
