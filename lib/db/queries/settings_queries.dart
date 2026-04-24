import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

class SettingsQueries {
  SettingsQueries._();

  static Future<String?> get(String key) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (rows.isEmpty) return null;
    return rows.first['value'] as String?;
  }

  static Future<void> set(String key, String value) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Map<String, String>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('settings');
    return {for (final row in rows) row['key'] as String: row['value'] as String};
  }
}
