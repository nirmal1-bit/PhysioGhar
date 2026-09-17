import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_settings_tile.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/auth/presentation/providers/auth_providers.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/utils/app_utils.dart';

class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  bool _darkModeEnabled = false;
  String _language = 'English';

  void _showLanguagePicker() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                trailing: _language == 'English'
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () {
                  setState(() => _language = 'English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('नेपाली'),
                trailing: _language == 'नेपाली'
                    ? const Icon(Icons.check_rounded)
                    : null,
                onTap: () {
                  setState(() => _language = 'नेपाली');
                  Navigator.pop(context);
                },
              ),
              const VerticalSpacing(AppDimensions.spacingMd),
            ],
          ),
        );
      },
    );
  }

  Future<void> _performLogout() async {
    await ref.read(authControllerProvider.notifier).logout();
    ref.invalidate(profileControllerProvider);
    if (!mounted) return;

    context.go(AppRoutes.login);
    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'You have been logged out',
    );
  }

  void _logout() {
    AppUtils.confirmationDialog(
      context: context,
      title: 'Log out?',
      message: 'You will need to sign in again to manage your practice.',
      onConfirm: _performLogout,
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileControllerProvider).valueOrNull;

    return Scaffold(
      appBar: const FilledAppBar(title: Text('Account')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingLg,
            AppDimensions.pagePadding,
            AppDimensions.spacingXxl,
          ),
          children: [
            _AccountHeader(
              profile: profile,
              onTap: () => context.push(AppRoutes.profileDetails),
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            const _SectionLabel('Account'),
            _SettingsCard(
              children: [
                AppSettingsTile(
                  icon: profile == null
                      ? Icons.person_add_alt_1_rounded
                      : Icons.person_outline_rounded,
                  title: profile == null ? 'Set up profile' : 'My profile',
                  subtitle: profile == null
                      ? 'Add your professional information'
                      : 'View your professional information',
                  onTap: () => context.push(
                    profile == null
                        ? AppRoutes.profileEdit
                        : AppRoutes.profileDetails,
                  ),
                ),
                if (profile != null)
                  AppSettingsTile(
                    icon: Icons.edit_outlined,
                    title: 'Edit profile',
                    subtitle: 'Update your details and specialization',
                    onTap: () => context.push(AppRoutes.profileEdit),
                  ),
                AppSettingsTile(
                  icon: Icons.event_available_outlined,
                  title: 'Availability',
                  subtitle: 'Manage when patients can book you',
                  onTap: () => context.go(AppRoutes.schedule),
                ),
              ],
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            const _SectionLabel('Preferences'),
            _SettingsCard(
              children: [
                AppSettingsTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: _language,
                  onTap: _showLanguagePicker,
                ),
                AppSettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark mode',
                  subtitle: 'Theme preference',
                  onTap: () =>
                      setState(() => _darkModeEnabled = !_darkModeEnabled),
                  trailing: Switch.adaptive(
                    value: _darkModeEnabled,
                    onChanged: (value) =>
                        setState(() => _darkModeEnabled = value),
                  ),
                ),
              ],
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            const _SectionLabel('Support & information'),
            _SettingsCard(
              children: [
                AppSettingsTile(
                  icon: Icons.report_problem_outlined,
                  title: 'Complaints / Report an issue',
                  subtitle: 'Contact PhysioGhar support',
                  onTap: () => context.push(AppRoutes.complaints),
                ),
                AppSettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy policy',
                  onTap: () => context.push(AppRoutes.privacyPolicy),
                ),
                AppSettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & conditions',
                  onTap: () => context.push(AppRoutes.terms),
                ),
              ],
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppSettingsTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              iconColor: AppColors.error,
              onTap: _logout,
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader({required this.profile, required this.onTap});

  final Profile? profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: Row(
          children: [
            AppAvatar(
              radius: 30,
              image: hasImage ? NetworkImage(imageUrl) : null,
            ),
            const HorizontalSpacing(AppDimensions.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.name ?? 'Complete your profile',
                    style: AppTextStyles.titleLarge,
                  ),
                  const VerticalSpacing(AppDimensions.spacingXs),
                  Text(
                    profile?.email ?? 'Set up your professional information',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.spacingSm),
      child: Text(label.toUpperCase(), style: AppTextStyles.eyebrow),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: AppDimensions.spacingSm),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}
