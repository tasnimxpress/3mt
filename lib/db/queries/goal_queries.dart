import 'package:uuid/uuid.dart';
import '../database_helper.dart';
import '../../core/utils/date_helpers.dart';

class GoalQueries {
  GoalQueries._();
  static const _uuid = Uuid();

  static Future<void> upsert(String categoryId, double target) async {
    final db = await DatabaseHelper.instance.database;
    final existing = await db.query(
      'saving_goals',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    final now = DateHelpers.toDateTimeString(DateTime.now());
    if (existing.isEmpty) {
      await db.insert('saving_goals', {
        'id': _uuid.v4(),
        'category_id': categoryId,
        'target': target,
        'created_at': now,
      });
    } else {
      await db.update(
        'saving_goals',
        {'target': target},
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    }
  }

  static Future<void> delete(String categoryId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'saving_goals',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  static Future<double?> getForCategory(String categoryId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'saving_goals',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    if (rows.isEmpty) return null;
    return (rows.first['target'] as num).toDouble();
  }

  static Future<Map<String, double>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('saving_goals');
    return {
      for (final row in rows)
        row['category_id'] as String: (row['target'] as num).toDouble(),
    };
  }
}
