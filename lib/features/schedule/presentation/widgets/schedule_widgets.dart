import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';

class ScheduleAvailabilityBanner extends StatelessWidget {
  const ScheduleAvailabilityBanner({
    required this.isAvailable,
    required this.isLoading,
    required this.onChanged,
    super.key,
  });

  final bool isAvailable;
  final bool isLoading;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
        vertical: AppDimensions.spacingMd,
      ),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.primarySurface : AppColors.neutral,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Row(
        children: [
          Icon(
            isAvailable
                ? Icons.check_circle_outline
                : Icons.pause_circle_outline,
            color: isAvailable ? AppColors.primary : AppColors.textMuted,
          ),
          const HorizontalSpacing(AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking availability', style: AppTextStyles.label),
                const VerticalSpacing(AppDimensions.spacingXs),
                Text(
                  isAvailable
                      ? 'Accepting new bookings'
                      : 'Not accepting bookings',
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
          if (isLoading)
            const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Switch.adaptive(value: isAvailable, onChanged: onChanged),
        ],
      ),
    );
  }
}

class ScheduleDaySelector extends StatelessWidget {
  const ScheduleDaySelector({
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

class ScheduleLegend extends StatelessWidget {
  const ScheduleLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
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

class ScheduleSlotTile extends StatelessWidget {
  const ScheduleSlotTile({required this.slot, required this.onTap, super.key});

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
          label: 'BOOKED',
          color: AppColors.accent,
          background: AppColors.accentSurface,
          icon: Icons.event_available_outlined,
        );
      case 'blocked':
        return const _SlotStyle(
          label: 'BLOCKED',
          color: AppColors.textMuted,
          background: AppColors.neutral,
          icon: Icons.block_outlined,
        );
      default:
        return const _SlotStyle(
          label: 'OPEN',
          color: AppColors.primary,
          background: AppColors.primarySurface,
          icon: Icons.check_circle_outline,
        );
    }
  }
}

class _SlotStyle {
  const _SlotStyle({
    required this.label,
    required this.color,
    required this.background,
    required this.icon,
  });

  final String label;
  final Color color;
  final Color background;
  final IconData icon;
}

class ScheduleEmptyState extends StatelessWidget {
  const ScheduleEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.textMuted,
            size: 34,
          ),
          const VerticalSpacing(AppDimensions.spacingSm),
          Text('No slots for this day', style: AppTextStyles.titleMedium),
          const VerticalSpacing(AppDimensions.spacingXs),
          Text(
            'Add an available time slot to start accepting bookings.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
