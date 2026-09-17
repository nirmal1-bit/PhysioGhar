import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_settings_tile.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({required this.onLogout, super.key});

  final VoidCallback onLogout;

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.pagePadding,
          AppDimensions.spacingLg,
          AppDimensions.pagePadding,
          AppDimensions.spacingXxl,
        ),
        children: [
          Text('Profile', style: AppTextStyles.headingSmall),
          const SizedBox(height: AppDimensions.spacingXl),
          const Column(
            children: [
              AppAvatar(radius: 44, showMedicalBadge: false),
              SizedBox(height: AppDimensions.spacingMd),
              Text('Patient account'),
              SizedBox(height: AppDimensions.spacingXs),
              Text('Manage your personal information and preferences'),
            ],
          ),
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
                  icon: Icons.lock_outline_rounded,
                  title: 'Privacy',
                  subtitle: 'Manage your privacy preferences',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXl),
          Card(
            child: AppSettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark mode',
              subtitle: 'Theme preference',
              trailing: Switch.adaptive(
                value: _darkModeEnabled,
                onChanged: (value) => setState(() => _darkModeEnabled = value),
              ),
              onTap: () => setState(() => _darkModeEnabled = !_darkModeEnabled),
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
            onTap: widget.onLogout,
          ),
        ],
      ),
    );
  }
}
