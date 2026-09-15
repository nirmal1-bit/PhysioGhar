import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class ScheduleDaySelectorWidget extends StatelessWidget {
  const ScheduleDaySelectorWidget({
    required this.weekStart,
    required this.selectedDate,
    required this.onSelected,
    super.key,
  });

  final DateTime weekStart;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppDimensions.spacingSm),
        itemBuilder: (context, index) {
          final date = weekStart.add(Duration(days: index));
          final isSelected = _sameDate(date, selectedDate);
          final isToday = _sameDate(date, DateTime.now());
          return InkWell(
            onTap: () => onSelected(date),
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 58,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacingSm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: isToday && !isSelected
                    ? Border.all(color: AppColors.primary, width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekday(date.weekday),
                    style: AppTextStyles.eyebrow.copyWith(
                      color: isSelected
                          ? AppColors.surface
                          : AppColors.textMuted,
                    ),
                  ),
                  const VerticalSpacing(AppDimensions.spacingXs),
                  Text(
                    '${date.day}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: isSelected
                          ? AppColors.surface
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _sameDate(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  String _weekday(int weekday) {
    const names = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return names[weekday - 1];
  }
}
