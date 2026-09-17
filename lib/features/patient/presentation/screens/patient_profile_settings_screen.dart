import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_settings_tile.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/features/auth/presentation/providers/auth_providers.dart';
import 'package:physioghar/features/patient/presentation/widgets/patient_bottom_nav_bar.dart';
import 'package:physioghar/utils/app_utils.dart';

class PatientProfileSettingsScreen extends ConsumerWidget {
  const PatientProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & settings')),
      bottomNavigationBar: const PatientBottomNavBar(selectedIndex: 1),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.pagePadding,
          AppDimensions.spacingLg,
          AppDimensions.pagePadding,
          AppDimensions.spacingXxl,
        ),
        children: [
          const _PatientProfileHeader(),
          const SizedBox(height: AppDimensions.sectionGap),
          Card(
            child: Column(
              children: [
                AppSettingsTile(
                  icon: Icons.person_outline_rounded,
                  title: 'My profile',
                  subtitle: 'View and update your personal details',
                  onTap: () {},
                ),
                AppSettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy policy',
                  subtitle: 'Learn how your information is used',
                  onTap: () {},
                ),
                AppSettingsTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & support',
                  subtitle: 'Get help with your bookings',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXl),
          AppSettingsTile(
            icon: Icons.logout_rounded,
            iconColor: AppColors.error,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.error,
            ),
            onTap: () => _confirmLogout(context, ref),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    AppUtils.confirmationDialog(
      context: context,
      title: 'Log out?',
      message: 'You will need to sign in again to book a session.',
      onConfirm: () async {
        await ref.read(authControllerProvider.notifier).logout();
        if (!context.mounted) return;
        context.go(AppRoutes.login);
        AppUtils.showSuccessSnackbar(
          context: context,
          message: 'You have been logged out',
        );
      },
    );
  }
}

class _PatientProfileHeader extends StatelessWidget {
  const _PatientProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppAvatar(radius: 44, showMedicalBadge: false),
        SizedBox(height: AppDimensions.spacingMd),
        Text('Patient account', style: AppTextStyles.titleLarge),
        SizedBox(height: AppDimensions.spacingXs),
        Text('Manage your account and preferences'),
      ],
    );
  }
}
