import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient/presentation/models/patient_booking_details_args.dart';
import 'package:physioghar/features/patient/presentation/providers/patient_booking_providers.dart';
import 'package:physioghar/features/patient/presentation/widgets/available_therapist_card_widget.dart';
import 'package:physioghar/features/patient/presentation/widgets/patient_bottom_nav_bar.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientBookingScreen extends ConsumerWidget {
  const PatientBookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientBookingProvider);
    final controller = ref.read(patientBookingProvider.notifier);
    final selectedDate = controller.selectedDate;
    return Scaffold(
      appBar: AppBar(title: const Text('Book a session')),
      bottomNavigationBar: const PatientBottomNavBar(selectedIndex: 0),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.selectDate(selectedDate),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePadding,
              AppDimensions.spacingLg,
              AppDimensions.pagePadding,
              AppDimensions.spacingXxl,
            ),
            children: [
              Text('Find a therapist', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.spacingXs),
              Text(
                'Choose a date to see therapists and open appointment times.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppDimensions.spacingLg),
              _DateSelector(
                selectedDate: selectedDate,
                onSelected: controller.selectDate,
              ),
              const SizedBox(height: AppDimensions.sectionGap),
              state.when(
                loading: () => const SizedBox(
                  height: 260,
                  child: AppLoadingWidget.small(),
                ),
                error: (error, _) => _BookingError(
                  error: error,
                  onRetry: () => controller.selectDate(selectedDate),
                ),
                data: (therapists) => therapists.isEmpty
                    ? const AppEmptyState(
                        icon: Icons.medical_services_outlined,
                        title: 'No therapists available',
                        message:
                            'Try another date to find an available physiotherapist.',
                      )
                    : Column(
                        children: therapists
                            .map(
                              (therapist) => AvailableTherapistCardWidget(
                                therapist: therapist,
                                onSlotSelected: (slot) => context.push(
                                  AppRoutes.patientBookingDetails,
                                  extra: PatientBookingDetailsArgs(
                                    therapist: therapist,
                                    slot: slot,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({required this.selectedDate, required this.onSelected});
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppDimensions.spacingSm),
        itemBuilder: (context, index) {
          final date = DateTime(today.year, today.month, today.day + index);
          final selected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;
          return InkWell(
            onTap: () => onSelected(date),
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            child: Ink(
              width: 58,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.neutral,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatWeekday(date),
                    style: AppTextStyles.label.copyWith(
                      color: selected ? Colors.white70 : null,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    '${date.day}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: selected ? Colors.white : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookingError extends StatelessWidget {
  const _BookingError({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? PatientBookingController.errorMessage(error as AppError)
        : 'Could not load available therapists';
    return AppEmptyState(
      icon: Icons.cloud_off_outlined,
      title: 'Something went wrong',
      message: message,
      actionLabel: 'Try again',
      onAction: onRetry,
    );
  }
}
