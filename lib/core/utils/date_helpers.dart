/// Date utilities for 3MT.
/// Critical: month ranges are NOT simple calendar months.
/// They depend on the month_start setting (1, 15, or 25).
class DateHelpers {
  DateHelpers._();

  /// Returns the start and end DateTime for the "month" containing [selected],
  /// given [startDay] (1, 15, or 25).
  ///
  /// Examples (startDay = 15):
  ///   selected = Apr 22 → start = Apr 15, end = May 14
  ///   selected = Apr 10 → start = Mar 15, end = Apr 14
  ///
  /// Examples (startDay = 1):
  ///   selected = Apr 22 → start = Apr 1,  end = Apr 30
  static ({DateTime start, DateTime end}) getMonthRange(
    DateTime selected,
    int startDay,
  ) {
    DateTime start;
    DateTime end;

    if (startDay == 1) {
      // Simple calendar month.
      start = DateTime(selected.year, selected.month, 1);
      end = DateTime(selected.year, selected.month + 1, 1)
          .subtract(const Duration(days: 1));
    } else {
      // Determine if selected day is before or on/after startDay.
      if (selected.day >= startDay) {
        // Period started this calendar month.
        start = DateTime(selected.year, selected.month, startDay);
        // End is (startDay - 1) of next calendar month.
        final DateTime nextMonthStart =
            DateTime(selected.year, selected.month + 1, startDay);
        end = nextMonthStart.subtract(const Duration(days: 1));
      } else {
        // Period started in the previous calendar month.
        final DateTime prevMonthStart =
            DateTime(selected.year, selected.month - 1, startDay);
        start = prevMonthStart;
        end = DateTime(selected.year, selected.month, startDay)
            .subtract(const Duration(days: 1));
      }
    }

    // Ensure end is end-of-day.
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);
    return (start: start, end: end);
  }

  /// Format a DateTime as ISO 8601 date string: '2026-04-22'
  static String toDateString(DateTime dt) {
    return '${dt.year.toString().padLeft(4, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
  }

  /// Format a DateTime as ISO 8601 datetime: '2026-04-22T10:32:00'
  static String toDateTimeString(DateTime dt) {
    return '${toDateString(dt)}T'
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  /// Parse a date string '2026-04-22' to DateTime.
  static DateTime parseDateString(String s) {
    final parts = s.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  /// Format for display in entry rows: "Apr 22, 2026"
  static String toDisplayDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  /// Format for Recent Activity timestamp: "Apr 22, 09:00 AM"
  static String toActivityTimestamp(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final amPm = dt.hour < 12 ? 'AM' : 'PM';
    return '${months[dt.month - 1]} ${dt.day}, ${hour.toString().padLeft(2, '0')}:$minute $amPm';
  }

  /// Format date for entry form display: "Today, Apr 22" or "Apr 15, 2026"
  static String toFormDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(dt.year, dt.month, dt.day);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    if (selected == today) {
      return 'Today, ${months[dt.month - 1]} ${dt.day}';
    }
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  /// Format month + year for header display: "April 2026"
  static String toMonthYear(DateTime dt) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[dt.month - 1]} ${dt.year}';
  }

  /// Navigate to previous "display month" (subtract 1 month from a
  /// DateTime that represents the selected period anchor).
  static DateTime previousMonth(DateTime dt) {
    if (dt.month == 1) return DateTime(dt.year - 1, 12, dt.day);
    return DateTime(dt.year, dt.month - 1, dt.day);
  }

  /// Navigate to next "display month".
  static DateTime nextMonth(DateTime dt) {
    if (dt.month == 12) return DateTime(dt.year + 1, 1, dt.day);
    return DateTime(dt.year, dt.month + 1, dt.day);
  }
}
