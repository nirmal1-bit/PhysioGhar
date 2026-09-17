import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({required this.onFindTherapist, super.key});

  final VoidCallback onFindTherapist;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.pagePadding,
          AppDimensions.spacingLg,
          AppDimensions.pagePadding,
          AppDimensions.spacingXxl,
        ),
        children: [
          Row(
            children: [
              const AppAvatar(radius: 24, showMedicalBadge: false),
              const SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back', style: AppTextStyles.bodySmall),
                    Text('Your care journey', style: AppTextStyles.titleLarge),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.sectionGap),
          Text('Your physiotherapy', style: AppTextStyles.headingSmall),
          const SizedBox(height: AppDimensions.spacingXs),
          Text(
            'Find a therapist and stay on top of your recovery plan.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppDimensions.spacingXl),
          Card(
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.health_and_safety_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  Text(
                    'Ready for your next session?',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    'Browse available therapists and book a time that works for you.',
                    style: AppTextStyles.body.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  AppPrimaryButton(
                    label: 'Find a therapist',
                    icon: Icons.search_rounded,
                    onPressed: onFindTherapist,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.sectionGap),
          Text('Upcoming session', style: AppTextStyles.titleLarge),
          const SizedBox(height: AppDimensions.spacingMd),
          const AppEmptyState(
            icon: Icons.calendar_month_outlined,
            title: 'No upcoming sessions',
            message: 'Your booked physiotherapy sessions will appear here.',
            compact: true,
          ),
        ],
      ),
    );
  }
}
