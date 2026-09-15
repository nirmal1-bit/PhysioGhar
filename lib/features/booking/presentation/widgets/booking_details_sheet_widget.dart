import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/utils/date_utils.dart';

class BookingDetailsSheetWidget extends StatelessWidget {
  const BookingDetailsSheetWidget({
    required this.booking,
    this.onAccept,
    this.onDecline,
    this.onComplete,
    this.onCancel,
    this.onReschedule,
    this.onNotes,
    super.key,
  });

  final Booking booking;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onNotes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.pagePadding,
          0,
          AppDimensions.pagePadding,
          AppDimensions.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.patientName, style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(booking.patientEmail, style: AppTextStyles.bodySmall),
            const SizedBox(height: AppDimensions.spacingLg),
            BookingDetailRowWidget(
              icon: Icons.medical_services_outlined,
              label: booking.treatment,
            ),
            BookingDetailRowWidget(
              icon: Icons.calendar_today_outlined,
              label: formatShortDate(booking.slotDate),
            ),
            BookingDetailRowWidget(
              icon: Icons.schedule_outlined,
              label:
                  '${booking.startTime.substring(0, 5)} - ${booking.endTime.substring(0, 5)}',
            ),
            BookingDetailRowWidget(
              icon: Icons.location_on_outlined,
              label: booking.location,
            ),
            BookingDetailRowWidget(
              icon: Icons.phone_outlined,
              label: booking.patientPhone,
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'Status: ${booking.status.toUpperCase()}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text('Therapist notes', style: AppTextStyles.label),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              booking.therapistNotes?.isNotEmpty == true
                  ? booking.therapistNotes!
                  : 'No remarks added yet.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            if (onNotes != null)
              OutlinedButton.icon(
                onPressed: onNotes,
                icon: const Icon(Icons.edit_note_outlined),
                label: Text(
                  booking.therapistNotes?.isNotEmpty == true
                      ? 'Edit notes'
                      : 'Add notes',
                ),
              ),
            if (onReschedule != null)
              OutlinedButton.icon(
                onPressed: onReschedule,
                icon: const Icon(Icons.event_repeat_outlined),
                label: const Text('Reschedule'),
              ),
            if (onAccept != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              AppPrimaryButton(
                label: 'Accept request',
                onPressed: onAccept,
                expanded: true,
              ),
            ],
            if (onComplete != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              AppPrimaryButton(
                label: 'Mark completed',
                onPressed: onComplete,
                expanded: true,
              ),
            ],
            if (onDecline != null || onCancel != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              TextButton(
                onPressed: onDecline ?? onCancel,
                child: Text(
                  onDecline != null ? 'Decline request' : 'Cancel session',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BookingDetailRowWidget extends StatelessWidget {
  const BookingDetailRowWidget({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.textMuted),
          const SizedBox(width: AppDimensions.spacingSm),
          Expanded(child: Text(label, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}
