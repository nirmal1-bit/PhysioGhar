import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient_note.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientNoteCardWidget extends StatelessWidget {
  const PatientNoteCardWidget({
    required this.note,
    required this.onEdit,
    super.key,
  });

  final PatientNote note;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatShortDate(note.createdAt),
                    style: AppTextStyles.label,
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  tooltip: 'Edit note',
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Text(note.note, style: AppTextStyles.bodyLarge),
            if (note.exercises?.isNotEmpty == true) ...[
              const SizedBox(height: AppDimensions.spacingMd),
              Text('Exercises', style: AppTextStyles.label),
              const SizedBox(height: AppDimensions.spacingXs),
              Text(note.exercises!, style: AppTextStyles.body),
            ],
            if (note.nextSession?.isNotEmpty == true) ...[
              const SizedBox(height: AppDimensions.spacingMd),
              Text('Next session', style: AppTextStyles.label),
              const SizedBox(height: AppDimensions.spacingXs),
              Text(note.nextSession!, style: AppTextStyles.body),
            ],
          ],
        ),
      ),
    );
  }
}
