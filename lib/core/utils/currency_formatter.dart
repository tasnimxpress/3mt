/// Bengali-style number grouping: 1,50,000 (not 1,500,000).
/// First group from right = 3 digits, all subsequent = 2 digits.
/// Currency symbol is prepended from settings — this class handles
/// only the numeric formatting.
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Format [amount] as a Bengali-grouped integer string.
  /// e.g. 150000 → "1,50,000"
  ///      20500  → "20,500"
  ///      500    → "500"
  static String formatAmount(double amount) {
    // Work with absolute value; sign handled by caller.
    final int absValue = amount.abs().round();
    final String digits = absValue.toString();

    if (digits.length <= 3) return digits;

    // Last 3 digits are always one group.
    final String lastThree = digits.substring(digits.length - 3);
    final String remaining = digits.substring(0, digits.length - 3);

    if (remaining.isEmpty) return lastThree;

    // Remaining digits are grouped in pairs from right.
    final StringBuffer result = StringBuffer();
    int count = 0;
    for (int i = remaining.length - 1; i >= 0; i--) {
      if (count > 0 && count % 2 == 0) {
        result.write(',');
      }
      result.write(remaining[i]);
      count++;
    }

    final String groupedRemaining =
        result.toString().split('').reversed.join('');
    return '$groupedRemaining,$lastThree';
  }

  /// Format with currency symbol and optional sign prefix.
  /// [symbol]   — e.g. 'BDT', '$', '€'
  /// [amount]   — raw double value (positive = income/saving, negative = expense)
  /// [showSign] — whether to prefix + or −
  static String format(String symbol, double amount, {bool showSign = false}) {
    final String formatted = formatAmount(amount);
    final String sign = showSign
        ? (amount >= 0 ? '+' : '−')
        : (amount < 0 ? '−' : '');
    return '$sign$symbol $formatted';
  }

  /// Format for display where sign is already encoded in type
  /// (entry rows, summary columns).
  static String formatWithSign(String symbol, double amount) {
    return format(symbol, amount, showSign: true);
  }

  /// Format bare number without symbol, with Bengali grouping.
  static String formatNumber(double amount) {
    return formatAmount(amount);
  }
}
