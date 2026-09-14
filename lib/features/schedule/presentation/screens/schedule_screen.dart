import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/schedule/data/models/schedule_slot.dart';
import 'package:physioghar/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:physioghar/features/schedule/presentation/widgets/schedule_widgets.dart';
import 'package:physioghar/utils/app_utils.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleControllerProvider);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => ref.read(scheduleControllerProvider.notifier).reload(),
        child: state.when(
          loading: () => const AppLoadingWidget.small(),
          error: (error, _) => _ScheduleError(
            error: error,
            onRetry: () =>
                ref.read(scheduleControllerProvider.notifier).reload(),
          ),
          data: (data) => _ScheduleContent(data: data),
        ),
      ),
    );
  }
}

class _ScheduleContent extends ConsumerStatefulWidget {
  const _ScheduleContent({required this.data});

  final ScheduleData data;

  @override
  ConsumerState<_ScheduleContent> createState() => _ScheduleContentState();
}

class _ScheduleContentState extends ConsumerState<_ScheduleContent> {
  bool _isAvailabilityLoading = false;
  bool _isActionLoading = false;

  Future<void> _changeAvailability(bool value) async {
    setState(() => _isAvailabilityLoading = true);
    final error = await ref
        .read(scheduleControllerProvider.notifier)
        .setAvailability(value);
    if (!mounted) return;
    setState(() => _isAvailabilityLoading = false);
    _showError(error);
  }

  Future<void> _changeSlotStatus(ScheduleSlot slot) async {
    if (slot.status == 'booked') return;
    final newStatus = slot.status == 'open' ? 'blocked' : 'open';
    final action = newStatus == 'blocked' ? 'Block slot' : 'Unblock slot';
    final shouldContinue = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(action, style: AppTextStyles.headingSmall),
              const VerticalSpacing(AppDimensions.spacingSm),
              Text(
                newStatus == 'blocked'
                    ? 'This slot will no longer be available for booking.'
                    : 'This slot will become available for booking again.',
                style: AppTextStyles.body,
              ),
              const VerticalSpacing(AppDimensions.spacingLg),
              AppPrimaryButton(
                label: action,
                onPressed: () => Navigator.of(context).pop(true),
                expanded: true,
              ),
            ],
          ),
        ),
      ),
    );
    if (shouldContinue != true || !mounted) return;

    setState(() => _isActionLoading = true);
    final error = await ref
        .read(scheduleControllerProvider.notifier)
        .changeSlotStatus(slotId: slot.id, status: newStatus);
    if (!mounted) return;
    setState(() => _isActionLoading = false);
    _showError(error);
  }

  Future<void> _addSlot() async {
    final startTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (startTime == null || !mounted) return;
    final endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: startTime.hour + 1,
        minute: startTime.minute,
      ),
    );
    if (endTime == null || !mounted) return;
    final start = _timeInMinutes(startTime);
    final end = _timeInMinutes(endTime);
    if (end <= start) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: 'End time must be later than start time',
      );
      return;
    }

    setState(() => _isActionLoading = true);
    final error = await ref
        .read(scheduleControllerProvider.notifier)
        .addSlot(
          date: widget.data.selectedDate,
          startTime: _timeValue(startTime),
          endTime: _timeValue(endTime),
        );
    if (!mounted) return;
    setState(() => _isActionLoading = false);
    _showError(error);
    if (error == null) {
      AppUtils.showSuccessSnackbar(
        context: context,
        message: 'Availability slot added',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlots = widget.data.selectedDaySlots;
    return Stack(
      children: [
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingLg,
            AppDimensions.pagePadding,
            110,
          ),
          children: [
            Text('Schedule', style: AppTextStyles.headingSmall),
            const VerticalSpacing(AppDimensions.spacingXs),
            Text(
              'Manage your availability and session times.',
              style: AppTextStyles.body,
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            ScheduleAvailabilityBanner(
              isAvailable: widget.data.availability.isAvailable,
              isLoading: _isAvailabilityLoading,
              onChanged: _changeAvailability,
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            Text('This week', style: AppTextStyles.titleLarge),
            const VerticalSpacing(AppDimensions.spacingMd),
            ScheduleDaySelector(
              weekStart: widget.data.schedule.weekStart,
              selectedDate: widget.data.selectedDate,
              onSelected: (date) => ref
                  .read(scheduleControllerProvider.notifier)
                  .selectDate(date),
            ),
            const VerticalSpacing(AppDimensions.spacingMd),
            const ScheduleLegend(),
            const VerticalSpacing(AppDimensions.spacingLg),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dateTitle(widget.data.selectedDate),
                    style: AppTextStyles.titleLarge,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addSlot,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add slot'),
                ),
              ],
            ),
            const VerticalSpacing(AppDimensions.spacingSm),
            if (selectedSlots.isEmpty)
              const ScheduleEmptyState()
            else
              ...selectedSlots.map(
                (slot) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.spacingMd,
                  ),
                  child: ScheduleSlotTile(
                    slot: slot,
                    onTap: () => _changeSlotStatus(slot),
                  ),
                ),
              ),
          ],
        ),
        if (_isActionLoading)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x33000000),
              child: AppLoadingWidget.small(color: AppColors.surface),
            ),
          ),
      ],
    );
  }

  void _showError(AppError? error) {
    if (error != null && mounted) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: ScheduleController.errorMessage(error),
      );
    }
  }

  int _timeInMinutes(TimeOfDay time) => time.hour * 60 + time.minute;

  String _timeValue(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  String _dateTitle(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}

class _ScheduleError extends StatelessWidget {
  const _ScheduleError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? ScheduleController.errorMessage(error as AppError)
        : 'Could not load your schedule';
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 420,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_outlined,
                  color: AppColors.textMuted,
                  size: 44,
                ),
                const VerticalSpacing(AppDimensions.spacingMd),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
                const VerticalSpacing(AppDimensions.spacingLg),
                TextButton(onPressed: onRetry, child: const Text('Try again')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
