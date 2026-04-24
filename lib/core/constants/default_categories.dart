/// Default category seed data for first launch.
/// 6 earning + 9 expense + 7 saving = 22 rows total.
/// All have is_default = 1 and cannot be deleted.
class DefaultCategories {
  DefaultCategories._();

  static List<Map<String, dynamic>> get all => [
        // ── EARNINGS ──────────────────────────────────────────────────────
        {
          'type': 'earning',
          'name': 'Salary',
          'icon': '💼',
          'sort_order': 1,
          'is_default': 1,
        },
        {
          'type': 'earning',
          'name': 'Freelance',
          'icon': '💻',
          'sort_order': 2,
          'is_default': 1,
        },
        {
          'type': 'earning',
          'name': 'Business',
          'icon': '🏪',
          'sort_order': 3,
          'is_default': 1,
        },
        {
          'type': 'earning',
          'name': 'Bonus',
          'icon': '🎯',
          'sort_order': 4,
          'is_default': 1,
        },
        {
          'type': 'earning',
          'name': 'Gift',
          'icon': '🎁',
          'sort_order': 5,
          'is_default': 1,
        },
        {
          'type': 'earning',
          'name': 'Other',
          'icon': '📥',
          'sort_order': 6,
          'is_default': 1,
        },

        // ── EXPENSES ──────────────────────────────────────────────────────
        {
          'type': 'expense',
          'name': 'Rent',
          'icon': '🏠',
          'sort_order': 1,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Food',
          'icon': '🍽️',
          'sort_order': 2,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Transport',
          'icon': '🚗',
          'sort_order': 3,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Utilities',
          'icon': '💡',
          'sort_order': 4,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Health',
          'icon': '🏥',
          'sort_order': 5,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Education',
          'icon': '📚',
          'sort_order': 6,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Entertainment',
          'icon': '🎬',
          'sort_order': 7,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Shopping',
          'icon': '🛍️',
          'sort_order': 8,
          'is_default': 1,
        },
        {
          'type': 'expense',
          'name': 'Other',
          'icon': '📤',
          'sort_order': 9,
          'is_default': 1,
        },

        // ── SAVINGS ───────────────────────────────────────────────────────
        {
          'type': 'saving',
          'name': 'DPS',
          'icon': '🏦',
          'sort_order': 1,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'Stocks',
          'icon': '📈',
          'sort_order': 2,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'FD',
          'icon': '🔒',
          'sort_order': 3,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'Emergency',
          'icon': '🛡️',
          'sort_order': 4,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'Mutual Fund',
          'icon': '📊',
          'sort_order': 5,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'Crypto',
          'icon': '₿',
          'sort_order': 6,
          'is_default': 1,
        },
        {
          'type': 'saving',
          'name': 'Cash Reserve',
          'icon': '💵',
          'sort_order': 7,
          'is_default': 1,
        },
      ];
}
