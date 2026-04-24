import 'package:uuid/uuid.dart';
import '../database_helper.dart';
import '../../models/category.dart';

class CategoryQueries {
  CategoryQueries._();
  static const _uuid = Uuid();

  static Future<List<Category>> getByType(String type) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'sort_order ASC',
    );
    return rows.map(Category.fromMap).toList();
  }

  static Future<Category?> getById(String id) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rows.isEmpty) return null;
    return Category.fromMap(rows.first);
  }

  static Future<String> insert({
    required String type,
    required String name,
    String icon = '📌',
  }) async {
    final db = await DatabaseHelper.instance.database;
    // Determine sort_order = max + 1 for this type.
    final maxRows = await db.rawQuery(
      'SELECT MAX(sort_order) as m FROM categories WHERE type = ?',
      [type],
    );
    final int maxOrder = (maxRows.first['m'] as int?) ?? 0;
    final String id = _uuid.v4();
    await db.insert('categories', {
      'id': id,
      'type': type,
      'name': name,
      'icon': icon,
      'color': null,
      'sort_order': maxOrder + 1,
      'is_default': 0,
    });
    return id;
  }

  static Future<void> delete(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('categories', where: 'id = ? AND is_default = 0', whereArgs: [id]);
  }

  /// Update sort_order for a list of category IDs in the given order.
  static Future<void> reorder(List<String> orderedIds) async {
    final db = await DatabaseHelper.instance.database;
    final batch = db.batch();
    for (int i = 0; i < orderedIds.length; i++) {
      batch.update(
        'categories',
        {'sort_order': i + 1},
        where: 'id = ?',
        whereArgs: [orderedIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }
}
