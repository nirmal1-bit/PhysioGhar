import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';

class AvailableTherapistCardWidget extends StatelessWidget {
  const AvailableTherapistCardWidget({
    required this.therapist,
    required this.onSlotSelected,
    super.key,
  });

  final AvailableTherapist therapist;
  final ValueChanged<AvailableSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    final imageUrl = therapist.profileImageUrl;
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppAvatar(
                  radius: 27,
                  showMedicalBadge: false,
                  image: imageUrl?.isNotEmpty == true
                      ? NetworkImage(imageUrl!)
                      : null,
                ),
                const SizedBox(width: AppDimensions.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(therapist.name, style: AppTextStyles.titleMedium),
                      if (therapist.specialization?.isNotEmpty == true)
                        Text(
                          therapist.specialization!,
                          style: AppTextStyles.bodySmall,
                        ),
                      if (therapist.experienceYears != null)
                        Text(
                          '${therapist.experienceYears} years experience',
                          style: AppTextStyles.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (therapist.address?.isNotEmpty == true) ...[
              const SizedBox(height: AppDimensions.spacingMd),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: AppDimensions.spacingXs),
                  Expanded(
                    child: Text(
                      therapist.address!,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppDimensions.spacingLg),
            Text('Available times', style: AppTextStyles.label),
            const SizedBox(height: AppDimensions.spacingSm),
            Wrap(
              spacing: AppDimensions.spacingSm,
              runSpacing: AppDimensions.spacingSm,
              children: therapist.slots
                  .map(
                    (slot) => OutlinedButton(
                      onPressed: () => onSlotSelected(slot),
                      child: Text(
                        '${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
