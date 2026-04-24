import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../utils/date_helpers.dart';

/// Runs once on every cold app launch (before runApp).
/// Creates auto-entries for any recurring rules whose next_date ≤ today.
/// Safe to call multiple times — deduplication prevents double entries.
class RecurringEngine {
  RecurringEngine._();

  static const _uuid = Uuid();

  static Future<void> processOverdue(Database db) async {
    final today = DateHelpers.toDateString(DateTime.now());

    // Fetch all rules where next_date is today or overdue.
    final List<Map<String, dynamic>> overdueRules = await db.query(
      'recurring_rules',
      where: 'next_date <= ?',
      whereArgs: [today],
    );

    for (final rule in overdueRules) {
      final String ruleId = rule['id'] as String;
      final String period = rule['period'] as String;
      String nextDate = rule['next_date'] as String;

      // Process all missed dates up to and including today.
      while (nextDate.compareTo(today) <= 0) {
        // Deduplicate: skip if entry already exists for this rule + date.
        final existing = await db.query(
          'entries',
          where: 'recur_rule_id = ? AND date = ?',
          whereArgs: [ruleId, nextDate],
        );

        if (existing.isEmpty) {
          final now = DateHelpers.toDateTimeString(DateTime.now());
          await db.insert('entries', {
            'id': _uuid.v4(),
            'type': rule['type'],
            'amount': rule['amount'],
            'category_id': rule['category_id'],
            'date': nextDate,
            'note': rule['note'],
            'is_recurring': 1,
            'recur_period': period,
            'recur_rule_id': ruleId,
            'created_at': now,
          });
        }

        // Advance next_date by one period.
        nextDate = _advanceDate(nextDate, period);
      }

      // Update the rule's next_date in DB.
      await db.update(
        'recurring_rules',
        {'next_date': nextDate},
        where: 'id = ?',
        whereArgs: [ruleId],
      );
    }
  }

  /// Advance [dateStr] by one [period] ('monthly' | 'weekly').
  static String _advanceDate(String dateStr, String period) {
    final dt = DateHelpers.parseDateString(dateStr);
    late DateTime advanced;
    if (period == 'weekly') {
      advanced = dt.add(const Duration(days: 7));
    } else {
      // Monthly: same day, next month.
      int month = dt.month + 1;
      int year = dt.year;
      if (month > 12) {
        month = 1;
        year++;
      }
      // Clamp day to last day of target month.
      final lastDay = DateTime(year, month + 1, 0).day;
      final day = dt.day > lastDay ? lastDay : dt.day;
      advanced = DateTime(year, month, day);
    }
    return DateHelpers.toDateString(advanced);
  }
}
