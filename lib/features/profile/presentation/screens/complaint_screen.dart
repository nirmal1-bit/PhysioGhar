import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/utils/app_utils.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'Patient Issue';

  static const _categories = [
    'Patient Issue',
    'Booking Issue',
    'Payment Issue',
    'Technical Issue',
    'Other',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'Your complaint has been submitted',
    );
    _subjectController.clear();
    _descriptionController.clear();
    setState(() => _category = _categories.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FilledAppBar(
        title: Text('Report an issue'),
        showLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tell us what went wrong and our support team will review it.',
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: [
                    for (final category in _categories)
                      DropdownMenuItem(value: category, child: Text(category)),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
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
                  textInputAction: TextInputAction.done,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Description is required'
                      : null,
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                AppPrimaryButton(
                  label: 'Submit complaint',
                  onPressed: _submit,
                  expanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
