import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    _NavigationTab(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard_rounded,
    ),
    _NavigationTab(
      label: 'Schedule',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month_rounded,
    ),
    _NavigationTab(
      label: 'Bookings',
      icon: Icons.event_note_outlined,
      activeIcon: Icons.event_note_rounded,
    ),
    _NavigationTab(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingSm,
              vertical: AppDimensions.spacingSm,
            ),
            child: GNav(
              selectedIndex: navigationShell.currentIndex,
              onTabChange: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
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
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 250),
              tabs: [
                for (var index = 0; index < _tabs.length; index++)
                  GButton(
                    icon: navigationShell.currentIndex == index
                        ? _tabs[index].activeIcon
                        : _tabs[index].icon,
                    text: _tabs[index].label,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationTab {
  const _NavigationTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => const _HomeTabContent(
    title: 'Good morning',
    subtitle: 'Here is your practice overview.',
    icon: Icons.dashboard_rounded,
  );
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) => const _HomeTabContent(
    title: 'Schedule',
    subtitle: 'Manage your availability and sessions.',
    icon: Icons.calendar_month_rounded,
  );
}

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) => const _HomeTabContent(
    title: 'Bookings',
    subtitle: 'Review your upcoming appointments.',
    icon: Icons.event_note_rounded,
  );
}

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.spacingLg),
            Text(title, style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(subtitle, style: AppTextStyles.body),
            const SizedBox(height: AppDimensions.spacingXxl),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.spacingXl),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              ),
              child: Icon(icon, color: AppColors.primary, size: 42),
            ),
          ],
        ),
      ),
    );
  }
}
