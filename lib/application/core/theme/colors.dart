import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE53935);
  static const Color primaryDark = Color(0xFFB71C1C);
  static const Color primaryDarker = Color(0xFFC62828);
  static const Color primaryLight = Color(0xFFEF9A9A);
  static const Color primarySurface = Color(0xFFFFEBEE);
  static const Color primarySurfaceLight = Color(0xFFFFF5F5);
  static const Color primarySurfaceLighter = Color(0xFFFFE8E8);
  static const Color primaryBorder = Color(0xFFFFCDD2);

  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundAlt = Color(0xFFE8EAF0);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color white = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF424242);
  static const Color textTertiary = Color(0xFF757575);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerLighter = Color(0xFFF0F0F0);
  static const Color dividerLightest = Color(0xFFF5F5F5);

  static const Color success = Color(0xFF43A047);
  static const Color successSurface = Color(0xFFE8F5E9);

  static const Color warning = Color(0xFFFB8C00);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningSurface = Color(0xFFFFF3E0);

  static const Color info = Color(0xFF1E88E5);
  static const Color infoSurface = Color(0xFFE3F2FD);

  static const Color avatarBlue = Color(0xFF1E88E5);
  static const Color avatarGreen = Color(0xFF43A047);
  static const Color avatarRed = Color(0xFFE53935);
  static const Color avatarOrange = Color(0xFFFB8C00);
  static const Color avatarPurple = Color(0xFF9C27B0);
  static const Color avatarTeal = Color(0xFF00ACC1);

  static const Color gold = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFFFA000);
  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFA8A9AD);

  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleRed = Color(0xFFEA4335);

  static const String fontFamily = 'Poppins';
}

Color colorFromHex(String hex) {
  final cleaned = hex.replaceFirst('#', '');
  final value = int.parse(cleaned.length == 6 ? 'FF$cleaned' : cleaned, radix: 16);
  return Color(value);
}
