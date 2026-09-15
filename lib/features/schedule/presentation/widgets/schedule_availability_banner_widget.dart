import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class ScheduleAvailabilityBannerWidget extends StatelessWidget {
  const ScheduleAvailabilityBannerWidget({
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
        vertical: AppDimensions.spacingMd,
      ),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.primarySurface : AppColors.neutral,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Row(
        children: [
          Icon(
            isAvailable
                ? Icons.check_circle_outline
                : Icons.pause_circle_outline,
            color: isAvailable ? AppColors.primary : AppColors.textMuted,
          ),
          const HorizontalSpacing(AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking availability', style: AppTextStyles.label),
                const VerticalSpacing(AppDimensions.spacingXs),
                Text(
                  isAvailable
                      ? 'Accepting new bookings'
                      : 'Not accepting bookings',
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
          if (isLoading)
            const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Switch.adaptive(value: isAvailable, onChanged: onChanged),
        ],
      ),
    );
  }
}
