import 'json.dart';

final class IntSize implements ToJson {
  const IntSize(this.width, this.height);

  factory IntSize.fromJson(Map<String, Object?> json) => IntSize(
        (json['width']! as num).toInt(),
        (json['height']! as num).toInt(),
      );

  final int width;
  final int height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is IntSize && height == other.height;

  @override
  int get hashCode => height.hashCode;

  int get area => width * height;

  IntSize operator *(int factor) => IntSize(width * factor, height * factor);

  IntSize round(double factor) =>
      IntSize((width * factor).round(), (height * factor).round());

  @override
  String toString() => "Size(${width}x$height)";

  @override
  Map<String, Object?> toJson() => {
        'width': width,
        'height': height,
      };
}
