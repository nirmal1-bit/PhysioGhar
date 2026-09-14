import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/data/models/request/profile_request.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/features/profile/presentation/widgets/profile_image_picker.dart';
import 'package:physioghar/utils/app_utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _experienceController = TextEditingController();
  final _specializationController = TextEditingController();
  final _addressController = TextEditingController();
  bool _didPopulate = false;
  bool _isEditing = false;
  XFile? _selectedImage;

  @override
  void dispose() {
    _experienceController.dispose();
    _specializationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _populate(Profile profile) {
    if (_didPopulate) return;
    _didPopulate = true;
    _isEditing = true;
    _experienceController.text = profile.experienceYears.toString();
    _specializationController.text = profile.specialization;
    _addressController.text = profile.address;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await ref
        .read(profileControllerProvider.notifier)
        .save(
          ProfileRequest(
            experienceYears: int.parse(_experienceController.text.trim()),
            specialization: _specializationController.text.trim(),
            address: _addressController.text.trim(),
            image: _selectedImage,
          ),
        );
    if (!mounted) return;

    if (error != null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: ProfileController.errorMessage(error),
      );
      return;
    }

    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'Profile saved successfully',
    );
    if (mounted) context.go(AppRoutes.profileDetails);
  }

  Future<void> _pickImage() async {
    final image = await AppUtils.pickImage();
    if (image != null && mounted) {
      setState(() => _selectedImage = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    ref.listen<AsyncValue<Profile?>>(profileControllerProvider, (_, next) {
      next.whenData((profile) {
        if (profile != null) _populate(profile);
      });
    });

    if (profileState.hasError) {
      final error = profileState.error;
      return Scaffold(
        appBar: FilledAppBar(
          title: Text(_isEditing ? 'Edit profile' : 'Set up profile'),
          showLeading: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.pagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 40,
                ),
                const VerticalSpacing(AppDimensions.spacingMd),
                Text(
                  error is AppError
                      ? ProfileController.errorMessage(error)
                      : 'Could not load your profile',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
                AppPrimaryButton(
                  label: 'Try again',
                  onPressed: () =>
                      ref.read(profileControllerProvider.notifier).reload(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (profileState.isLoading && !profileState.hasValue) {
      return Scaffold(
        appBar: FilledAppBar(
          title: Text(_isEditing ? 'Edit profile' : 'Set up profile'),
          showLeading: true,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final profile = profileState.valueOrNull;
    if (profile != null) _populate(profile);
    final isSaving = profileState.isLoading;

    return Scaffold(
      appBar: FilledAppBar(
        title: Text(_isEditing ? 'Edit profile' : 'Set up profile'),
        showLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingLg,
            AppDimensions.pagePadding,
            AppDimensions.spacingXxl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImagePicker(
                  profile: profile,
                  selectedImage: _selectedImage,
                  onTap: _pickImage,
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                Text('Professional details', style: AppTextStyles.titleLarge),
                const VerticalSpacing(AppDimensions.spacingMd),
                AppTextField(
                  controller: _experienceController,
                  label: 'Experience (years)',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    final parsed = int.tryParse(value?.trim() ?? '');
                    if (parsed == null || parsed < 0) {
                      return 'Enter a valid number of years';
                    }
                    return null;
                  },
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
                AppTextField(
                  controller: _specializationController,
                  label: 'Specialization',
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: _requiredValidator('Specialization'),
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
                AppTextField(
                  controller: _addressController,
                  label: 'Address',
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  validator: _requiredValidator('Address'),
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                AppPrimaryButton(
                  label: _isEditing ? 'Save changes' : 'Create profile',
                  onPressed: _save,
                  isLoading: isSaving,
                  expanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? Function(String?) _requiredValidator(String label) {
    return (value) =>
        value == null || value.trim().isEmpty ? '$label is required' : null;
  }
}
