import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile.profileImageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return Column(
      children: [
        AppAvatar(radius: 48, image: hasImage ? NetworkImage(imageUrl) : null),
        const VerticalSpacing(AppDimensions.spacingMd),
        Text(profile.name, style: AppTextStyles.headingSmall),
        const VerticalSpacing(AppDimensions.spacingXs),
        Text(profile.email, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const HorizontalSpacing(AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodySmall),
                const VerticalSpacing(AppDimensions.spacingXs),
                Text(value, style: AppTextStyles.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileErrorState extends StatelessWidget {
  const ProfileErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 40),
            const VerticalSpacing(AppDimensions.spacingMd),
            Text(message, textAlign: TextAlign.center),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppPrimaryButton(label: 'Try again', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
