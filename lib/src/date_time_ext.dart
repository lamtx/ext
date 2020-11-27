extension DateTimeExt on DateTime {
  DateTime today() {
    return DateTime(year, month, day);
  }

  bool isToday() {
    return isSameDay(DateTime.now());
  }

  bool isYesterday() {
    return isSameDay(DateTime.now().subtract(const Duration(days: 1)));
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  bool isSameWeek(DateTime other, int firstDayOfWeek) {
    final diff =
        other.difference(this).inMicroseconds + Duration.microsecondsPerDay - 1;
    final daysBetween = diff ~/ Duration.microsecondsPerDay;

    if (daysBetween > DateTime.daysPerWeek ||
        daysBetween < -DateTime.daysPerWeek) {
      return false;
    }

    var d1 = weekday - firstDayOfWeek;
    var d2 = other.weekday - firstDayOfWeek;
    if (d1 < 0) {
      d1 += DateTime.daysPerWeek;
    }
    if (d2 < 0) {
      d2 += DateTime.daysPerWeek;
    }

    return daysBetween >= 0 ? d1 <= d2 : d2 <= d1;
  }

  DateTime getFirstDayInWeek(int firstDayOfWeek) {
    var daysBetween = weekday - firstDayOfWeek;
    if (daysBetween < 0) {
      daysBetween += DateTime.daysPerWeek;
    }
    return DateTime(year, month, day - daysBetween);
  }

  DateTime getLastDayInWeek(int firstDayOfWeek) {
    var daysBetween = firstDayOfWeek - weekday - 1;
    if (daysBetween < 0) {
      daysBetween += DateTime.daysPerWeek;
    }
    return DateTime(year, month, day + daysBetween);
  }
}
