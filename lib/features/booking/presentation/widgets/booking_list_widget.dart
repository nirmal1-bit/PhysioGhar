import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/utils/date_utils.dart';

class BookingListWidget extends StatelessWidget {
  const BookingListWidget({
    required this.bookings,
    required this.emptyMessage,
    required this.onTap,
    super.key,
  });

  final List<Booking> bookings;
  final String emptyMessage;
  final ValueChanged<Booking> onTap;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          child: Text(emptyMessage, style: AppTextStyles.bodySmall),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingLg,
        AppDimensions.pagePadding,
        AppDimensions.spacingXxl,
      ),
      itemCount: bookings.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimensions.spacingMd),
      itemBuilder: (context, index) => BookingCardWidget(
        booking: bookings[index],
        onTap: () => onTap(bookings[index]),
      ),
    );
  }
}

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({
    required this.booking,
    required this.onTap,
    super.key,
  });

  final Booking booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primarySurface,
                child: Text(
                  booking.patientName.substring(0, 1).toUpperCase(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.patientName, style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingXs),
                    Text(booking.treatment, style: AppTextStyles.bodySmall),
                    const SizedBox(height: AppDimensions.spacingXs),
                    Text(
                      '${formatShortDate(booking.slotDate)} · ${booking.startTime.substring(0, 5)}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              BookingStatusPillWidget(status: booking.status),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingStatusPillWidget extends StatelessWidget {
  const BookingStatusPillWidget({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isPositive = status == 'accepted' || status == 'completed';
    final isPending = status == 'pending';
    final color = isPending
        ? AppColors.accent
        : isPositive
        ? AppColors.success
        : AppColors.error;
    final background = isPending
        ? AppColors.accentSurface
        : isPositive
        ? AppColors.primarySurface
        : AppColors.errorSurface;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          status.toUpperCase(),
          style: AppTextStyles.eyebrow.copyWith(color: color, fontSize: 9),
        ),
      ),
    );
  }
}
