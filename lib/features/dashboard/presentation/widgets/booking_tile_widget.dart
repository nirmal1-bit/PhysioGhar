import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';

class BookingTileWidget extends StatelessWidget {
  const BookingTileWidget({
    required this.booking,
    required this.onTap,
    super.key,
  });

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
