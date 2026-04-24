import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'schema.dart';
import 'seed.dart';

/// Singleton database helper.
/// Opens '3mt_database.db', creates tables on first launch,
/// seeds default data on first launch.
class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '3mt_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create all 6 tables.
    for (final sql in Schema.all) {
      await db.execute(sql);
    }
    // Seed default data — runs only when DB file is brand new.
    await Seed.insertDefaultCategories(db);
    await Seed.insertDefaultSettings(db);
  }

  // Scaffold present for future milestones — empty for now.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations go here when version > 1.
  }

  /// Drop all tables and recreate schema + seed.
  /// Used by Danger Zone "Clear All Data" and Backup Restore.
  Future<void> resetDatabase() async {
    final db = await database;
    for (final tableName in Schema.tableNames.reversed) {
      await db.execute('DROP TABLE IF EXISTS $tableName');
    }
    for (final sql in Schema.all) {
      await db.execute(sql);
    }
    await Seed.insertDefaultCategories(db);
    await Seed.insertDefaultSettings(db);
  }
}
