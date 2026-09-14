import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/dashboard/data/models/response/booking.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({required this.profile, required this.date, super.key});

  final Profile? profile;
  final String date;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return Row(
      children: [
        AppAvatar(radius: 27, image: hasImage ? NetworkImage(imageUrl) : null),
        const HorizontalSpacing(AppDimensions.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning,', style: AppTextStyles.bodySmall),
              const VerticalSpacing(AppDimensions.spacingXs),
              Text(
                profile?.name ?? 'Therapist',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleLarge,
              ),
              const VerticalSpacing(AppDimensions.spacingXs),
              Text(date, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class AvailabilityCard extends StatelessWidget {
  const AvailabilityCard({
    required this.isAvailable,
    required this.isLoading,
    required this.onChanged,
    super.key,
  });

  final bool isAvailable;
  final bool isLoading;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.primarySurface : AppColors.neutral,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            decoration: BoxDecoration(
              color: isAvailable ? AppColors.primary : AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAvailable ? Icons.visibility_rounded : Icons.visibility_off,
              color: isAvailable ? AppColors.surface : AppColors.textMuted,
            ),
          ),
          const HorizontalSpacing(AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your availability', style: AppTextStyles.label),
                const VerticalSpacing(AppDimensions.spacingXs),
                Text(
                  isAvailable
                      ? 'Available for bookings'
                      : 'Currently unavailable',
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
          if (isLoading)
            const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Switch.adaptive(value: isAvailable, onChanged: onChanged),
        ],
      ),
    );
  }
}

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const VerticalSpacing(AppDimensions.spacingSm),
            Text('$value', style: AppTextStyles.numberLarge),
            const VerticalSpacing(AppDimensions.spacingXs),
            Text(label, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}

class DashboardSectionHeader extends StatelessWidget {
  const DashboardSectionHeader({required this.title, this.action, super.key});

  final String title;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.titleLarge)),
        if (action != null)
          TextButton(onPressed: action, child: const Text('See all')),
      ],
    );
  }
}

class BookingTile extends StatelessWidget {
  const BookingTile({required this.booking, required this.onTap, super.key});

  final Booking booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = booking.status == 'pending';
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Row(
            children: [
              Container(
                width: 54,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: isPending
                      ? AppColors.accentSurface
                      : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppDimensions.spacingSm),
                ),
                child: Column(
                  children: [
                    Text(
                      booking.startTime.substring(0, 5),
                      style: AppTextStyles.label.copyWith(
                        color: isPending ? AppColors.accent : AppColors.primary,
                      ),
                    ),
                    const VerticalSpacing(AppDimensions.spacingXs),
                    Text('TIME', style: AppTextStyles.eyebrow),
                  ],
                ),
              ),
              const HorizontalSpacing(AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.patientName, style: AppTextStyles.titleMedium),
                    const VerticalSpacing(AppDimensions.spacingXs),
                    Text(booking.treatment, style: AppTextStyles.bodySmall),
                    const VerticalSpacing(AppDimensions.spacingXs),
                    Text(booking.location, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardEmptyState extends StatelessWidget {
  const DashboardEmptyState({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.event_available_outlined,
            color: AppColors.textMuted,
            size: 32,
          ),
          const VerticalSpacing(AppDimensions.spacingSm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
