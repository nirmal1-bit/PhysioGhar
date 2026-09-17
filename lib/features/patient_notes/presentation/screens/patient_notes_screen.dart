import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient_notes/presentation/providers/patient_notes_providers.dart';
import 'package:physioghar/features/patient_notes/presentation/widgets/patient_record_tile_widget.dart';

class PatientNotesScreen extends ConsumerWidget {
  const PatientNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientNotesProvider);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => ref.read(patientNotesProvider.notifier).reload(),
        child: state.when(
          loading: () => const AppLoadingWidget.small(),
          error: (error, _) => _PatientNotesError(
            error: error,
            onRetry: () => ref.read(patientNotesProvider.notifier).reload(),
          ),
          data: (patients) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePadding,
              AppDimensions.spacingLg,
              AppDimensions.pagePadding,
              AppDimensions.spacingXxl,
            ),
            children: [
              Text('Patients', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.spacingXs),
              Text(
                'Review patient history and session notes.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppDimensions.sectionGap),
              if (patients.isEmpty)
                const SizedBox(
                  height: 420,
                  child: Center(
                    child: AppEmptyState(
                      icon: Icons.people_outline_rounded,
                      title: 'No patient records yet',
                      message:
                          'Patients will appear here after they book a session with you.',
                      compact: true,
                    ),
                  ),
                )
              else
                ...patients.map(
                  (patient) => PatientRecordTileWidget(
                    patient: patient,
                    onTap: () => context.push('/main/patients/${patient.id}'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatientNotesError extends StatelessWidget {
  const _PatientNotesError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? PatientNotesController.errorMessage(error as AppError)
        : 'Could not load patients';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
