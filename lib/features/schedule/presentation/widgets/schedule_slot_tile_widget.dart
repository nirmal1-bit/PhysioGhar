import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';

class ScheduleSlotTileWidget extends StatelessWidget {
  const ScheduleSlotTileWidget({
    required this.slot,
    required this.onTap,
    super.key,
  });

  final ScheduleSlot slot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(slot.status);
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: style.background,
                  borderRadius: BorderRadius.circular(AppDimensions.spacingSm),
                ),
                child: Icon(style.icon, color: style.color, size: 22),
              ),
              const HorizontalSpacing(AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_displayTime(slot.startTime)} - ${_displayTime(slot.endTime)}',
                      style: AppTextStyles.titleMedium,
                    ),
                    const VerticalSpacing(AppDimensions.spacingXs),
                    Text(
                      style.label,
                      style: AppTextStyles.eyebrow.copyWith(color: style.color),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _displayTime(String value) {
    final parts = value.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final minute = parts.length > 1 ? parts[1] : '00';
    final suffix = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:$minute $suffix';
  }

  _SlotStyle _statusStyle(String status) {
    switch (status) {
      case 'booked':
        return const _SlotStyle(
          'BOOKED',
          AppColors.accent,
          AppColors.accentSurface,
          Icons.event_available_outlined,
        );
      case 'blocked':
        return const _SlotStyle(
          'BLOCKED',
          AppColors.textMuted,
          AppColors.neutral,
          Icons.block_outlined,
        );
      default:
        return const _SlotStyle(
          'OPEN',
          AppColors.primary,
          AppColors.primarySurface,
          Icons.check_circle_outline,
        );
    }
  }
}

class _SlotStyle {
  const _SlotStyle(this.label, this.color, this.background, this.icon);

  final String label;
  final Color color;
  final Color background;
  final IconData icon;
}
