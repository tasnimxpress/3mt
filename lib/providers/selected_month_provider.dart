import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global selected month — shared across all 4 tabs.
/// Initialized to the current month on app launch.
final selectedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  // Anchor to 1st of the month so month_start arithmetic is consistent.
  return DateTime(now.year, now.month, 1);
});
