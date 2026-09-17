import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient/presentation/models/patient_booking_details_args.dart';
import 'package:physioghar/features/patient/presentation/providers/patient_booking_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientBookingDetailsScreen extends ConsumerStatefulWidget {
  const PatientBookingDetailsScreen({required this.args, super.key});
  final PatientBookingDetailsArgs args;

  @override
  ConsumerState<PatientBookingDetailsScreen> createState() =>
      _PatientBookingDetailsScreenState();
}

class _PatientBookingDetailsScreenState
    extends ConsumerState<PatientBookingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _treatment = TextEditingController();
  final _location = TextEditingController(text: 'Clinic');
  final _condition = TextEditingController();
  final _age = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _email,
      _phone,
      _treatment,
      _location,
      _condition,
      _age,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.args.therapist;
    final slot = widget.args.slot;
    return Scaffold(
      appBar: AppBar(title: const Text('Booking details')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePadding,
              AppDimensions.spacingLg,
              AppDimensions.pagePadding,
              AppDimensions.spacingXxl,
            ),
            children: [
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(AppDimensions.spacingMd),
                  title: Text(therapist.name, style: AppTextStyles.titleMedium),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimensions.spacingXs,
                    ),
                    child: Text(
                      '${formatShortDate(slot.slotDate)} · ${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}',
                    ),
                  ),
                  leading: const Icon(Icons.calendar_month_outlined),
                ),
              ),
              const SizedBox(height: AppDimensions.sectionGap),
              Text('Your details', style: AppTextStyles.titleLarge),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _name,
                label: 'Full name',
                validator: _required,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _email,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@')
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _phone,
                label: 'Phone',
                keyboardType: TextInputType.phone,
                validator: _required,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _treatment,
                label: 'Treatment / service',
                validator: _required,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _location,
                label: 'Location',
                hint: 'Home visit or clinic',
                validator: _required,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _condition,
                label: 'Condition',
                hint: 'Optional',
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _age,
                label: 'Age',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppDimensions.spacingXl),
              AppPrimaryButton(
                label: 'Request booking',
                expanded: true,
                isLoading: _isSaving,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final args = widget.args;
    final error = await ref
        .read(patientBookingProvider.notifier)
        .book(
          therapistId: args.therapist.id,
          slotId: args.slot.id,
          patientName: _name.text,
          patientEmail: _email.text,
          patientPhone: _phone.text,
          treatment: _treatment.text,
          location: _location.text,
          patientCondition: _condition.text,
          patientAge: int.tryParse(_age.text.trim()),
        );
    if (!mounted) return;
    if (error != null) {
      setState(() => _isSaving = false);
      AppUtils.showErrorSnackbar(
        context: context,
        message: PatientBookingController.errorMessage(error),
      );
      return;
    }
    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'Booking request sent',
    );
    context.pop();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;
}
