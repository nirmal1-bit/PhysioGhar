import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';

class PatientBottomNavBar extends StatelessWidget {
  const PatientBottomNavBar({required this.selectedIndex, super.key});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(
        AppDimensions.spacingLg,
        AppDimensions.spacingSm,
        AppDimensions.spacingLg,
        AppDimensions.spacingSm,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingSm),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) => context.go(
              index == 0
                  ? AppRoutes.patientHome
                  : AppRoutes.patientProfileSettings,
            ),
            gap: AppDimensions.spacingSm,
            haptic: true,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMd,
              vertical: AppDimensions.spacingMd,
            ),
            tabBorderRadius: AppDimensions.pillRadius,
            activeColor: AppColors.primary,
            color: AppColors.textMuted,
            tabBackgroundColor: AppColors.primarySurface,
            tabs: const [
              GButton(icon: Icons.calendar_month_outlined, text: 'Book'),
              GButton(icon: Icons.person_outline_rounded, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
