import 'package:flutter/material.dart';
import 'colors.dart';

/// All TextStyle definitions for 3MT.
/// Three typefaces:
///   InstrumentSerif  — display / balance figures
///   DMSans           — all UI / labels / buttons
///   JetBrainsMono    — every currency value
class AppTextStyles {
  AppTextStyles._();

  // ── Instrument Serif ──────────────────────────────────────────────────────

  /// 42px — primary balance display (Available to Spend)
  static const TextStyle balanceDisplay = TextStyle(
    fontFamily: 'InstrumentSerif',
    fontSize: 42,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  // ── DM Sans ───────────────────────────────────────────────────────────────

  /// 16px Medium — section titles, tab screen main title
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  /// 15px Medium — card titles
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  /// 13px Regular — body / labels
  static const TextStyle body = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 13px Bold — bold body (entry row category name)
  static const TextStyle bodyBold = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  /// 11px Regular — secondary / subtitles
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// 11px Regular in secondary color (most common subtitle use)
  static const TextStyle subtitleSecondary = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// 10px Regular — tiny labels (column headers, bar labels)
  static const TextStyle tinyLabel = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// 13px Regular — button text base
  static const TextStyle button = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  /// 13px Medium — settings row label
  static const TextStyle settingsLabel = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // ── JetBrains Mono ────────────────────────────────────────────────────────

  /// 14px Regular — standard amount values
  static const TextStyle amount = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 15px Regular — larger amounts in history rows
  static const TextStyle amountLarge = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 32px Regular — amount input in entry form
  static const TextStyle amountInput = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
