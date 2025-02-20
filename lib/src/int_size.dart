import 'json.dart';

final class IntSize implements ToJson {
  const IntSize(this.width, this.height) : assert(width >= 0 && height >= 0);

  factory IntSize.fromJson(Map<String, Object?> json) => IntSize(
        (json['width']! as num).toInt(),
        (json['height']! as num).toInt(),
      );

  final int width;
  final int height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntSize && width == other.width && height == other.height;

  @override
  int get hashCode => width.hashCode ^ height.hashCode;

  int get area => width * height;

  double get aspectRatio {
    if (height != 0) {
      return width / height;
    }
    if (width > 0) {
      return double.infinity;
    }
    if (width < 0) {
      return double.negativeInfinity;
    }
    return 0;
  }

  IntSize operator *(int factor) => IntSize(width * factor, height * factor);

  IntSize operator ~/(int factor) => IntSize(width ~/ factor, height ~/ factor);

  @override
  String toString() => "Size(${width}x$height)";

  @override
  Map<String, Object?> toJson() => {
        'width': width,
        'height': height,
      };
}
