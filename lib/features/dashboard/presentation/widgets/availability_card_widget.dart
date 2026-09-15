import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class AvailabilityCardWidget extends StatelessWidget {
  const AvailabilityCardWidget({
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
