import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({
    required this.profile,
    required this.date,
    super.key,
  });

  final Profile? profile;
  final String date;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return Row(
      children: [
        Semantics(
          button: true,
          label: 'Open profile',
          child: GestureDetector(
            onTap: () => context.go(AppRoutes.profileDetails),
            child: AppAvatar(
              radius: 27,
              image: hasImage ? NetworkImage(imageUrl) : null,
            ),
          ),
        ),
        const HorizontalSpacing(AppDimensions.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning,', style: AppTextStyles.bodySmall),
              const VerticalSpacing(AppDimensions.spacingXs),
              Text(
                profile?.name ?? 'Therapist',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleLarge,
              ),
              const VerticalSpacing(AppDimensions.spacingXs),
              Text(date, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}
