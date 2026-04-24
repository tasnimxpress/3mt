import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/queries/entry_queries.dart';
import '../models/entry.dart';
import 'settings_provider.dart';

/// All entries for a given (month, type) pair.
final entriesProvider = FutureProvider.family<List<Entry>, (DateTime, String)>(
  (ref, args) async {
    final (month, type) = args;
    final settings = ref.watch(settingsProvider.notifier);
    return EntryQueries.getByMonthAndType(month, settings.monthStart, type);
  },
);

/// All entries (all types) for a given month — used by Dashboard Recent Activity.
final allEntriesProvider = FutureProvider.family<List<Entry>, DateTime>(
  (ref, month) async {
    final settings = ref.watch(settingsProvider.notifier);
    return EntryQueries.getByMonth(month, settings.monthStart);
  },
);
