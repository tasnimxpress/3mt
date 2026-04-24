import 'package:flutter/material.dart';

/// All hex color tokens for 3MT design system.
/// These are the single source of truth — never hardcode hex elsewhere.
class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF13131A);
  static const Color border = Color(0xFF1E1E2E);
  static const Color unallocated = Color(0xFF3A3A4A);

  // ── Pillar Accents ────────────────────────────────────────────────────────
  static const Color earn = Color(0xFF00D68F);
  static const Color spend = Color(0xFFFF4D6D);
  static const Color save = Color(0xFFF5A623);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF7B7B9A);

  // ── Semantic overlays (for banners / warning backgrounds) ─────────────────
  static const Color earnOverlay = Color(0x1400D68F); // ~8% opacity
  static const Color spendOverlay = Color(0x14FF4D6D);
  static const Color saveOverlay = Color(0x14F5A623);

  // ── Delete / Edit swipe backgrounds ──────────────────────────────────────
  static const Color deleteBackground = Color(0xFFFF4D6D);
  static const Color editBackground = Color(0xFF1E1E2E);
}
