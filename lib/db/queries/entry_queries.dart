import 'package:uuid/uuid.dart';
import '../database_helper.dart';
import '../../models/entry.dart';
import '../../core/utils/date_helpers.dart';

class EntryQueries {
  EntryQueries._();
  static const _uuid = Uuid();

  static Future<List<Entry>> getByMonth(
    DateTime selected,
    int startDay,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final range = DateHelpers.getMonthRange(selected, startDay);
    final startStr = DateHelpers.toDateString(range.start);
    final endStr = DateHelpers.toDateString(range.end);
    final rows = await db.query(
      'entries',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startStr, endStr],
      orderBy: 'date DESC, created_at DESC',
    );
    return rows.map(Entry.fromMap).toList();
  }

  static Future<List<Entry>> getByMonthAndType(
    DateTime selected,
    int startDay,
    String type,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final range = DateHelpers.getMonthRange(selected, startDay);
    final startStr = DateHelpers.toDateString(range.start);
    final endStr = DateHelpers.toDateString(range.end);
    final rows = await db.query(
      'entries',
      where: 'type = ? AND date >= ? AND date <= ?',
      whereArgs: [type, startStr, endStr],
      orderBy: 'date DESC, created_at DESC',
    );
    return rows.map(Entry.fromMap).toList();
  }

  static Future<String> insert(Entry entry) async {
    final db = await DatabaseHelper.instance.database;
    final map = entry.toMap();
    map['id'] = _uuid.v4();
    await db.insert('entries', map);
    return map['id'] as String;
  }

  static Future<void> update(Entry entry) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  static Future<void> delete(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('entries', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Entry>> getRecentActivity(
    DateTime selected,
    int startDay, {
    int limit = 5,
  }) async {
    final all = await getByMonth(selected, startDay);
    return all.take(limit).toList();
  }
}
