import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient/data/models/response/available_therapist.dart';
import 'package:physioghar/features/patient/presentation/providers/patient_booking_providers.dart';
import 'package:physioghar/features/patient/presentation/widgets/available_therapist_card_widget.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientBookingScreen extends ConsumerWidget {
  const PatientBookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientBookingProvider);
    final selectedDate = ref.read(patientBookingProvider.notifier).selectedDate;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(patientBookingProvider.notifier).selectDate(selectedDate),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingLg,
            AppDimensions.pagePadding,
            AppDimensions.spacingXxl,
          ),
          children: [
            Text('Book a session', style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              'Choose a date, therapist, and available time.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            _DateSelector(
              selectedDate: selectedDate,
              onSelected: (date) =>
                  ref.read(patientBookingProvider.notifier).selectDate(date),
            ),
            const SizedBox(height: AppDimensions.sectionGap),
            state.when(
              loading: () =>
                  const SizedBox(height: 260, child: AppLoadingWidget.small()),
              error: (error, _) => _BookingError(
                error: error,
                onRetry: () => ref
                    .read(patientBookingProvider.notifier)
                    .selectDate(selectedDate),
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
                              onSlotSelected: (slot) => _showBookingForm(
                                context,
                                ref,
                                therapist,
                                slot,
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showBookingForm(
    BuildContext context,
    WidgetRef ref,
    AvailableTherapist therapist,
    AvailableSlot slot,
  ) async {
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();
    final treatment = TextEditingController();
    final location = TextEditingController();
    final condition = TextEditingController();
    final age = TextEditingController();
    var isSaving = false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            0,
            AppDimensions.pagePadding,
            MediaQuery.viewInsetsOf(context).bottom + AppDimensions.pagePadding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book with ${therapist.name}',
                    style: AppTextStyles.headingSmall,
                  ),
                  const SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    '${formatShortDate(slot.slotDate)} · ${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  AppTextField(
                    controller: name,
                    label: 'Full name',
                    validator: _required,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: email,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || !value.contains('@')
                        ? 'Enter a valid email'
                        : null,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: phone,
                    label: 'Phone',
                    keyboardType: TextInputType.phone,
                    validator: _required,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: treatment,
                    label: 'Treatment / service',
                    validator: _required,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: location,
                    label: 'Location',
                    hint: 'Home visit or clinic',
                    validator: _required,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: condition,
                    label: 'Condition',
                    hint: 'Optional',
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  AppTextField(
                    controller: age,
                    label: 'Age',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  AppPrimaryButton(
                    label: 'Request booking',
                    expanded: true,
                    isLoading: isSaving,
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      setState(() => isSaving = true);
                      final error = await ref
                          .read(patientBookingProvider.notifier)
                          .book(
                            therapistId: therapist.id,
                            slotId: slot.id,
                            patientName: name.text,
                            patientEmail: email.text,
                            patientPhone: phone.text,
                            treatment: treatment.text,
                            location: location.text,
                            patientCondition: condition.text,
                            patientAge: int.tryParse(age.text.trim()),
                          );
                      if (!context.mounted) return;
                      if (error != null) {
                        setState(() => isSaving = false);
                        AppUtils.showErrorSnackbar(
                          context: context,
                          message: PatientBookingController.errorMessage(error),
                        );
                        return;
                      }
                      Navigator.pop(sheetContext);
                      AppUtils.showSuccessSnackbar(
                        context: context,
                        message: 'Booking request sent',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    name.dispose();
    email.dispose();
    phone.dispose();
    treatment.dispose();
    location.dispose();
    condition.dispose();
    age.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;
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
          final isSelected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;
          return InkWell(
            onTap: () => onSelected(date),
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            child: Ink(
              width: 58,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.neutral,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatWeekday(date),
                    style: AppTextStyles.label.copyWith(
                      color: isSelected ? Colors.white70 : null,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    '${date.day}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: isSelected ? Colors.white : null,
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
