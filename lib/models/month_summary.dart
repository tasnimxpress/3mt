/// Holds all computed monthly totals.
/// Computed live — never stored in DB.
class MonthSummary {
  final double totalEarned;
  final double totalSpent;
  final double totalSaved;

  const MonthSummary({
    required this.totalEarned,
    required this.totalSpent,
    required this.totalSaved,
  });

  // ── Derived values ────────────────────────────────────────────────────────

  double get netBalance => totalEarned - totalSpent;
  double get availableToSpend => totalEarned - totalSpent - totalSaved;

  double get healthScore =>
      totalEarned > 0 ? (totalSaved / totalEarned) * 100 : 0;

  double get actualSavePct =>
      totalEarned > 0 ? (totalSaved / totalEarned) * 100 : 0;

  double get actualSpendPct =>
      totalEarned > 0 ? (totalSpent / totalEarned) * 100 : 0;

  double get freePct => 100 - actualSavePct - actualSpendPct;

  double get spentPctOfEarned =>
      totalEarned > 0 ? (totalSpent / totalEarned) * 100 : 0;

  double get savedPctOfEarned =>
      totalEarned > 0 ? (totalSaved / totalEarned) * 100 : 0;

  double get unallocatedPct =>
      totalEarned > 0 ? (100 - spentPctOfEarned - savedPctOfEarned).clamp(0, 100) : 100;

  static const MonthSummary empty = MonthSummary(
    totalEarned: 0,
    totalSpent: 0,
    totalSaved: 0,
  );
}
