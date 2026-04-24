import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/queries/computed_queries.dart';
import '../models/month_summary.dart';
import 'settings_provider.dart';

final summaryProvider = FutureProvider.family<MonthSummary, DateTime>(
  (ref, month) async {
    final settings = ref.watch(settingsProvider.notifier);
    final totals =
        await ComputedQueries.getMonthTotals(month, settings.monthStart);
    return MonthSummary(
      totalEarned: totals['totalEarned'] ?? 0,
      totalSpent: totals['totalSpent'] ?? 0,
      totalSaved: totals['totalSaved'] ?? 0,
    );
  },
);
