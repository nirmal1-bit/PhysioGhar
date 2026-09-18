import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/complaint.dart';
import 'package:physioghar/features/profile/presentation/providers/complaint_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class ComplaintScreen extends ConsumerStatefulWidget {
  const ComplaintScreen({super.key});

  @override
  ConsumerState<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends ConsumerState<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _category = _ComplaintCategory.patientIssue;
  var _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    AppUtils.hideKeyboard();
    setState(() => _isSubmitting = true);
    final error = await ref
        .read(complaintControllerProvider.notifier)
        .submit(
          category: _category.value,
          subject: _subjectController.text.trim(),
          description: _descriptionController.text.trim(),
        );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (error != null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: ComplaintController.errorMessage(error),
      );
      return;
    }
    _subjectController.clear();
    _descriptionController.clear();
    setState(() => _category = _ComplaintCategory.patientIssue);
    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'Your complaint has been submitted',
    );
  }

  @override
  Widget build(BuildContext context) {
    final complaintsState = ref.watch(complaintControllerProvider);
    return Scaffold(
      appBar: const FilledAppBar(
        title: Text('Report an issue'),
        showLeading: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          children: [
            Text('How can we help?', style: AppTextStyles.headingSmall),
            const VerticalSpacing(AppDimensions.spacingXs),
            const Text(
              'Tell us what went wrong and our support team will review it.',
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<_ComplaintCategory>(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: [
                      for (final category in _ComplaintCategory.values)
                        DropdownMenuItem(
                          value: category,
                          child: Text(category.label),
                        ),
                    ],
                    onChanged: _isSubmitting
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _category = value);
                            }
                          },
                  ),
                  const VerticalSpacing(AppDimensions.spacingLg),
                  AppTextField(
                    controller: _subjectController,
                    label: 'Subject',
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Subject is required'
                        : null,
                  ),
                  const VerticalSpacing(AppDimensions.spacingLg),
                  AppTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    maxLines: 5,
                    maxLength: 10000,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Description is required'
                        : null,
                  ),
                  const VerticalSpacing(AppDimensions.spacingXl),
                  AppPrimaryButton(
                    label: 'Submit complaint',
                    onPressed: _isSubmitting ? null : _submit,
                    isLoading: _isSubmitting,
                    expanded: true,
                  ),
                ],
              ),
            ),
            const VerticalSpacing(AppDimensions.spacingXxl),
            Text('Previous reports', style: AppTextStyles.titleLarge),
            const VerticalSpacing(AppDimensions.spacingMd),
            complaintsState.when(
              loading: () => const AppLoadingWidget.small(),
              error: (error, _) => Text(
                error is AppError
                    ? ComplaintController.errorMessage(error)
                    : 'Could not load previous reports',
              ),
              data: (complaints) => complaints.isEmpty
                  ? const AppEmptyState(
                      icon: Icons.inbox_outlined,
                      title: 'No previous reports',
                      message: 'Your submitted complaints will appear here.',
                      compact: true,
                    )
                  : Column(
                      children: [
                        for (final complaint in complaints)
                          _ComplaintCard(complaint: complaint),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ComplaintCategory {
  patientIssue('patient_issue', 'Patient Issue'),
  bookingIssue('booking_issue', 'Booking Issue'),
  paymentIssue('payment_issue', 'Payment Issue'),
  technicalIssue('technical_issue', 'Technical Issue'),
  other('other', 'Other');

  const _ComplaintCategory(this.value, this.label);

  final String value;
  final String label;
}

class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard({required this.complaint});

  final Complaint complaint;

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
                    complaint.subject,
                    style: AppTextStyles.titleMedium,
                  ),
                ),
                Chip(label: Text(_statusLabel(complaint.status))),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              _categoryLabel(complaint.category),
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(complaint.description, style: AppTextStyles.body),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              formatShortDate(complaint.createdAt),
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  static String _categoryLabel(String value) => value
      .split('_')
      .map(
        (part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1)}',
      )
      .join(' ');

  static String _statusLabel(String value) => value == 'in_review'
      ? 'In review'
      : '${value[0].toUpperCase()}${value.substring(1)}';
}
