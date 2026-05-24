import 'dart:ui';

class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────
  static const Color primary = Color(0xFF0D4A1F); // forest green
  static const Color primaryLight = Color(0xFF1B6B31); // hover / lighter tint
  static const Color accent = Color(0xFFFF6B35); // warm orange CTA

  // ── Backgrounds ────────────────────────────────────
  static const Color background = Color(0xFFFFF8F0); // warm off-white
  static const Color surface = Color(0xFFFFFFFF); // cards
  static const Color surfaceMuted = Color(0xFFF2F2F2); // image containers

  // ── Text ───────────────────────────────────────────
  static const Color mainText = Color(0xFF1A1A1A);
  static const Color subText = Color(0xFF6B6B6B);
  static const Color hintText = Color(0xFF9E9E9E);

  // ── Semantic ───────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF5A623);

  // ── Utility ────────────────────────────────────────
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color moreGreyText = Color(0xFFBDBDBD);
}
