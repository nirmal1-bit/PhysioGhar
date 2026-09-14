import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    ('Dashboard', Icons.dashboard_outlined, Icons.dashboard_rounded),
    ('Schedule', Icons.calendar_month_outlined, Icons.calendar_month_rounded),
    ('Bookings', Icons.event_note_outlined, Icons.event_note_rounded),
    ('Profile', Icons.person_outline_rounded, Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isProfileEditRoute =
        GoRouterState.of(context).uri.path == AppRoutes.profileEdit;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: isProfileEditRoute
          ? null
          : SafeArea(
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
                    tabs: [
                      for (var index = 0; index < _tabs.length; index++)
                        GButton(
                          icon: navigationShell.currentIndex == index
                              ? _tabs[index].$3
                              : _tabs[index].$2,
                          text: _tabs[index].$1,
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}


class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: Text('Schedule'));
}

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: Text('Bookings'));
}
