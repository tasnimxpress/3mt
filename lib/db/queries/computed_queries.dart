import '../database_helper.dart';
import '../../core/utils/date_helpers.dart';

class ComputedQueries {
  ComputedQueries._();

  /// Returns {totalEarned, totalSpent, totalSaved} for [selected] month.
  static Future<Map<String, double>> getMonthTotals(
    DateTime selected,
    int startDay,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final range = DateHelpers.getMonthRange(selected, startDay);
    final startStr = DateHelpers.toDateString(range.start);
    final endStr = DateHelpers.toDateString(range.end);

    double sumForType(List<Map<String, dynamic>> rows) {
      if (rows.isEmpty || rows.first['total'] == null) return 0.0;
      return (rows.first['total'] as num).toDouble();
    }

    final earned = await db.rawQuery(
      "SELECT SUM(amount) as total FROM entries WHERE type='earning' AND date >= ? AND date <= ?",
      [startStr, endStr],
    );
    final spent = await db.rawQuery(
      "SELECT SUM(amount) as total FROM entries WHERE type='expense' AND date >= ? AND date <= ?",
      [startStr, endStr],
    );
    final saved = await db.rawQuery(
      "SELECT SUM(amount) as total FROM entries WHERE type='saving' AND date >= ? AND date <= ?",
      [startStr, endStr],
    );

    return {
      'totalEarned': sumForType(earned),
      'totalSpent': sumForType(spent),
      'totalSaved': sumForType(saved),
    };
  }

  /// Returns per-category totals for expenses in [selected] month.
  static Future<Map<String, double>> getCategoryTotals(
    DateTime selected,
    int startDay,
    String type,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final range = DateHelpers.getMonthRange(selected, startDay);
    final startStr = DateHelpers.toDateString(range.start);
    final endStr = DateHelpers.toDateString(range.end);

    final rows = await db.rawQuery(
      '''SELECT category_id, SUM(amount) as total
         FROM entries
         WHERE type = ? AND date >= ? AND date <= ?
         GROUP BY category_id''',
      [type, startStr, endStr],
    );

    return {
      for (final row in rows)
        row['category_id'] as String: (row['total'] as num).toDouble(),
    };
  }

  /// All-time total saved for a specific saving category (for goals).
  static Future<double> getAllTimeSavedForCategory(String categoryId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.rawQuery(
      "SELECT SUM(amount) as total FROM entries WHERE type='saving' AND category_id = ?",
      [categoryId],
    );
    if (rows.isEmpty || rows.first['total'] == null) return 0.0;
    return (rows.first['total'] as num).toDouble();
  }
}
