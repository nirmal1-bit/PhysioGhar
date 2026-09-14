import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/extensions/string_extensions.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/data/models/request/profile_request.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/utils/app_utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _specializationController = TextEditingController();
  final _addressController = TextEditingController();
  bool _didPopulate = false;
  bool _isEditing = false;
  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _specializationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _populate(Profile profile) {
    if (_didPopulate) return;
    _didPopulate = true;
    _isEditing = true;
    _nameController.text = profile.name;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
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
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
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
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
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
                _ProfileImagePicker(
                  profile: profile,
                  selectedImage: _selectedImage,
                  onTap: _pickImage,
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                Text('Basic information', style: AppTextStyles.titleLarge),
                const VerticalSpacing(AppDimensions.spacingMd),
                AppTextField(
                  controller: _nameController,
                  label: 'Full name',
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: _requiredValidator('Name'),
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.trim().isValidEmail) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const VerticalSpacing(AppDimensions.spacingXl),
                Text('Professional details', style: AppTextStyles.titleLarge),
                const VerticalSpacing(AppDimensions.spacingMd),
                AppTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: _requiredValidator('Phone'),
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
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

class _ProfileImagePicker extends StatelessWidget {
  const _ProfileImagePicker({
    required this.profile,
    required this.selectedImage,
    required this.onTap,
  });

  final Profile? profile;
  final XFile? selectedImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    final hasNetworkImage = imageUrl != null && imageUrl.isNotEmpty;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(52),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.primarySurface,
                backgroundImage: selectedImage != null
                    ? FileImage(File(selectedImage!.path))
                    : hasNetworkImage
                    ? NetworkImage(imageUrl)
                    : null,
                child: selectedImage == null && !hasNetworkImage
                    ? const Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                        size: 48,
                      )
                    : null,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(AppDimensions.spacingSm),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.surface,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpacing(AppDimensions.spacingMd),
        Text(
          profile == null ? 'Add profile photo' : 'Change profile photo',
          style: AppTextStyles.titleMedium,
        ),
        const VerticalSpacing(AppDimensions.spacingXs),
        Text(
          'Choose an image from your device',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
