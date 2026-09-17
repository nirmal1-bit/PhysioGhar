import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientRecordTileWidget extends StatelessWidget {
  const PatientRecordTileWidget({
    required this.patient,
    required this.onTap,
    super.key,
  });

  final Patient patient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(AppDimensions.spacingMd),
        leading: CircleAvatar(
          backgroundColor: AppColors.primarySurface,
          foregroundColor: AppColors.primary,
          child: Text(patient.name.substring(0, 1).toUpperCase()),
        ),
        title: Text(patient.name, style: AppTextStyles.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppDimensions.spacingXs),
          child: Text(
            '${patient.age == null ? 'Age unavailable' : '${patient.age} years'} · ${patient.condition}',
            style: AppTextStyles.bodySmall,
          ),
        ),
        trailing: patient.lastSessionDate == null
            ? const Icon(Icons.chevron_right_rounded)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Last session', style: AppTextStyles.label),
                  Text(
                    formatShortDate(patient.lastSessionDate!),
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }
}
