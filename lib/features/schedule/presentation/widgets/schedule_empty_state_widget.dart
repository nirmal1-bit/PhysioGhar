import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class ScheduleEmptyStateWidget extends StatelessWidget {
  const ScheduleEmptyStateWidget({super.key});

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
            Icons.calendar_today_outlined,
            color: AppColors.textMuted,
            size: 34,
          ),
          const VerticalSpacing(AppDimensions.spacingSm),
          Text('No slots for this day', style: AppTextStyles.titleMedium),
          const VerticalSpacing(AppDimensions.spacingXs),
          Text(
            'Add an available time slot to start accepting bookings.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
