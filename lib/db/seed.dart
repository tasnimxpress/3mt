import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../core/constants/default_categories.dart';

/// Seeds default data into the database on first launch (inside onCreate).
class Seed {
  Seed._();

  static const _uuid = Uuid();

  /// Insert all 22 default categories (6 earning + 9 expense + 7 saving).
  static Future<void> insertDefaultCategories(Database db) async {
    for (final cat in DefaultCategories.all) {
      await db.insert('categories', {
        'id': _uuid.v4(),
        'type': cat['type'],
        'name': cat['name'],
        'icon': cat['icon'],
        'color': null,
        'sort_order': cat['sort_order'],
        'is_default': cat['is_default'],
      });
    }
  }

  /// Insert the 8 default settings key-value rows.
  static Future<void> insertDefaultSettings(Database db) async {
    final defaults = {
      'currency': 'BDT',
      'theme': 'dark',
      'month_start': '1',
      'haptic': 'true',
      'target_save_pct': '30',
      'target_spend_pct': '50',
      'last_backup': '',
      'nudge_dismissed_date': '',
    };
    for (final entry in defaults.entries) {
      await db.insert('settings', {
        'key': entry.key,
        'value': entry.value,
      });
    }
  }
}
