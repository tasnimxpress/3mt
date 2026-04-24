import 'package:uuid/uuid.dart';
import '../database_helper.dart';
import '../../core/utils/date_helpers.dart';

class BudgetQueries {
  BudgetQueries._();
  static const _uuid = Uuid();

  static Future<void> upsert(String categoryId, double amount) async {
    final db = await DatabaseHelper.instance.database;
    final existing = await db.query(
      'budget_limits',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    final now = DateHelpers.toDateTimeString(DateTime.now());
    if (existing.isEmpty) {
      await db.insert('budget_limits', {
        'id': _uuid.v4(),
        'category_id': categoryId,
        'amount': amount,
        'created_at': now,
      });
    } else {
      await db.update(
        'budget_limits',
        {'amount': amount},
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    }
  }

  static Future<void> delete(String categoryId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'budget_limits',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  static Future<double?> getForCategory(String categoryId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'budget_limits',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    if (rows.isEmpty) return null;
    return (rows.first['amount'] as num).toDouble();
  }

  static Future<Map<String, double>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('budget_limits');
    return {
      for (final row in rows)
        row['category_id'] as String: (row['amount'] as num).toDouble(),
    };
  }
}
