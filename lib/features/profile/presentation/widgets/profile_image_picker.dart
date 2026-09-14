import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physioghar/core/common/widgets/app_avatar.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    required this.profile,
    required this.selectedImage,
    required this.onTap,
    super.key,
  });

  final Profile? profile;
  final XFile? selectedImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = profile?.profileImageUrl;
    final hasNetworkImage = imageUrl != null && imageUrl.isNotEmpty;

    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(52),
            child: Stack(
              children: [
                AppAvatar(
                  radius: 52,
                  image: selectedImage != null
                      ? FileImage(File(selectedImage!.path))
                      : hasNetworkImage
                      ? NetworkImage(imageUrl)
                      : null,
                ),
                Positioned(
                  left: 0,
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
      ),
    );
  }
}
