/// All CREATE TABLE SQL strings for 3MT.
/// Used in DatabaseHelper.onCreate and also in restore (drop + recreate).
class Schema {
  Schema._();

  static const String entries = '''
    CREATE TABLE entries (
      id            TEXT PRIMARY KEY,
      type          TEXT NOT NULL,
      amount        REAL NOT NULL,
      category_id   TEXT NOT NULL,
      date          TEXT NOT NULL,
      note          TEXT,
      is_recurring  INTEGER DEFAULT 0,
      recur_period  TEXT,
      recur_rule_id TEXT,
      created_at    TEXT NOT NULL
    )
  ''';

  static const String categories = '''
    CREATE TABLE categories (
      id         TEXT PRIMARY KEY,
      type       TEXT NOT NULL,
      name       TEXT NOT NULL,
      icon       TEXT,
      color      TEXT,
      sort_order INTEGER DEFAULT 0,
      is_default INTEGER DEFAULT 0
    )
  ''';

  static const String budgetLimits = '''
    CREATE TABLE budget_limits (
      id          TEXT PRIMARY KEY,
      category_id TEXT NOT NULL,
      amount      REAL NOT NULL,
      created_at  TEXT NOT NULL
    )
  ''';

  static const String savingGoals = '''
    CREATE TABLE saving_goals (
      id          TEXT PRIMARY KEY,
      category_id TEXT NOT NULL,
      target      REAL NOT NULL,
      created_at  TEXT NOT NULL
    )
  ''';

  static const String recurringRules = '''
    CREATE TABLE recurring_rules (
      id          TEXT PRIMARY KEY,
      type        TEXT NOT NULL,
      amount      REAL NOT NULL,
      category_id TEXT NOT NULL,
      period      TEXT NOT NULL,
      note        TEXT,
      next_date   TEXT NOT NULL,
      created_at  TEXT NOT NULL
    )
  ''';

  static const String settings = '''
    CREATE TABLE settings (
      key   TEXT PRIMARY KEY,
      value TEXT NOT NULL
    )
  ''';

  static const List<String> all = [
    entries,
    categories,
    budgetLimits,
    savingGoals,
    recurringRules,
    settings,
  ];

  static const List<String> tableNames = [
    'entries',
    'categories',
    'budget_limits',
    'saving_goals',
    'recurring_rules',
    'settings',
  ];
}
