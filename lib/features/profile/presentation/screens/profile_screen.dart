import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final _imageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _specializationController = TextEditingController();
  final _addressController = TextEditingController();
  bool _didPopulate = false;
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _imageController.dispose();
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
    _imageController.text = profile.profileImageUrl ?? '';
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
            profileImageUrl: _imageController.text.trim().isEmpty
                ? null
                : _imageController.text.trim(),
            phone: _phoneController.text.trim(),
            experienceYears: int.parse(_experienceController.text.trim()),
            specialization: _specializationController.text.trim(),
            address: _addressController.text.trim(),
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
                _ProfileHeader(profile: profile),
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
                  controller: _imageController,
                  label: 'Profile image URL (optional)',
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.primarySurface,
          backgroundImage: imageUrl == null || imageUrl.isEmpty
              ? null
              : NetworkImage(imageUrl),
          child: imageUrl == null || imageUrl.isEmpty
              ? const Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                  size: 32,
                )
              : null,
        ),
        const HorizontalSpacing(AppDimensions.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile?.name ?? 'Complete your profile',
                style: AppTextStyles.titleLarge,
              ),
              const VerticalSpacing(AppDimensions.spacingXs),
              Text(
                profile?.email ?? 'Add your professional details below',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
