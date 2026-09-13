import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// shared typography for the PhysioGhar therapist app.
abstract final class AppTextStyles {
  static final headingLarge = GoogleFonts.fraunces(
    color: AppColors.textPrimary,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.1,
  );

  static final headingMedium = GoogleFonts.fraunces(
    color: AppColors.textPrimary,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.15,
  );

  static final headingSmall = GoogleFonts.fraunces(
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final titleLarge = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final titleMedium = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final bodyLarge = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 16,
    height: 1.5,
  );

  static final body = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 14,
    height: 1.45,
  );

  static final bodySmall = GoogleFonts.inter(
    color: AppColors.textSecondary,
    fontSize: 12,
    height: 1.4,
  );

  static final button = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final label = GoogleFonts.inter(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static final eyebrow = GoogleFonts.ibmPlexMono(
    color: AppColors.textMuted,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static final numberLarge = GoogleFonts.fraunces(
    color: AppColors.textPrimary,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.1,
  );
}
