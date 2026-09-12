import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary brand and gradient colors.
  static const primary = Color(0xFF2F5D50);
  static const secondary = Color(0xFF3F7965);
  static const primarySurface = Color(0xFFD1E8DF);

  // Neutral surfaces and accent colors.
  static const neutral = Color(0xFFEEF1ED);
  static const accent = Color(0xFFE2962F);
  static const accentSurface = Color(0xFFFBEFD9);
  static const background = Color(0xFFFBFBF8);
  static const surface = Colors.white;

  // Text hierarchy.
  static const textPrimary = Color(0xFF1E2A2E);
  static const textSecondary = Color(0xFF4A5854);
  static const textMuted = Color(0xFF8FA8A0);

  // Error and destructive-action colors.
  static const error = Color(0xFFC84B4B);
  static const errorSurface = Color(0xFFFCE8E8);
}
