import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class ScheduleLegendWidget extends StatelessWidget {
  const ScheduleLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _LegendItem(label: 'OPEN', color: AppColors.primary),
        SizedBox(width: AppDimensions.spacingMd),
        _LegendItem(label: 'BOOKED', color: AppColors.accent),
        SizedBox(width: AppDimensions.spacingMd),
        _LegendItem(label: 'BLOCKED', color: AppColors.textMuted),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppDimensions.spacingXs),
        Text(label, style: AppTextStyles.eyebrow),
      ],
    );
  }
}
