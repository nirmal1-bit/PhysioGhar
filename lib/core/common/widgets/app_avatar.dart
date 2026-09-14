import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.image,
    this.radius = 48,
    this.showMedicalBadge = true,
    super.key,
  });

  final ImageProvider<Object>? image;
  final double radius;
  final bool showMedicalBadge;

  @override
  Widget build(BuildContext context) {
    final diameter = radius * 2;

    return SizedBox(
      width: diameter + 12,
      height: diameter + 12,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: diameter + 4,
            height: diameter + 4,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: AppColors.primarySurface,
              backgroundImage: image,
              child: image == null
                  ? Icon(
                      Icons.person_rounded,
                      color: AppColors.primary,
                      size: radius * 0.92,
                    )
                  : null,
            ),
          ),
          if (showMedicalBadge)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: radius * 0.55,
                height: radius * 0.55,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Icon(
                  Icons.health_and_safety_outlined,
                  color: AppColors.surface,
                  size: radius * 0.34,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
