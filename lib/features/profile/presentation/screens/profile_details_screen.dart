import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/features/profile/presentation/widgets/profile_details_widgets.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);

    if (profileState.isLoading && !profileState.hasValue) {
      return const Scaffold(
        appBar: FilledAppBar(title: Text('My profile'), showLeading: true),
        body: AppLoadingWidget.small(),
      );
    }

    if (profileState.hasError) {
      final error = profileState.error;
      return Scaffold(
        appBar: const FilledAppBar(
          title: Text('My profile'),
          showLeading: true,
        ),
        body: ProfileErrorState(
          message: error is AppError
              ? ProfileController.errorMessage(error)
              : 'Could not load your profile',
          onRetry: () => ref.read(profileControllerProvider.notifier).reload(),
        ),
      );
    }

    final profile = profileState.valueOrNull;
    if (profile == null) {
      return const _ProfileSetupView();
    }

    return _ProfileDetailsView(profile: profile);
  }
}

class _ProfileSetupView extends StatelessWidget {
  const _ProfileSetupView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FilledAppBar(title: Text('My profile'), showLeading: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacingXl),
                decoration: const BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),
              const VerticalSpacing(AppDimensions.spacingXl),
              Text('Set up your profile', style: AppTextStyles.headingSmall),
              const VerticalSpacing(AppDimensions.spacingSm),
              Text(
                'Add your professional details so patients can learn more about you before booking.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
              const VerticalSpacing(AppDimensions.spacingXl),
              AppPrimaryButton(
                label: 'Set up profile',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.push(AppRoutes.profileEdit),
                expanded: true,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileDetailsView extends StatelessWidget {
  const _ProfileDetailsView({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilledAppBar(
        title: const Text('My profile'),
        showLeading: true,
        actions: [
          IconButton(
            tooltip: 'Edit profile',
            onPressed: () => context.push(AppRoutes.profileEdit),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingLg,
            AppDimensions.pagePadding,
            AppDimensions.spacingXxl,
          ),
          children: [
            ProfileHero(profile: profile),
            const VerticalSpacing(AppDimensions.spacingXl),
            Text('Professional details', style: AppTextStyles.titleLarge),
            const VerticalSpacing(AppDimensions.spacingSm),
            ProfileDetailsCard(
              children: [
                ProfileDetailRow(
                  icon: Icons.work_outline_rounded,
                  label: 'Experience',
                  value: '${profile.experienceYears} years',
                ),
                ProfileDetailRow(
                  icon: Icons.medical_services_outlined,
                  label: 'Specialization',
                  value: profile.specialization,
                ),
                ProfileDetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  value: profile.address,
                ),
              ],
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppPrimaryButton(
              label: 'Edit profile',
              icon: Icons.edit_outlined,
              onPressed: () => context.push(AppRoutes.profileEdit),
              expanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
