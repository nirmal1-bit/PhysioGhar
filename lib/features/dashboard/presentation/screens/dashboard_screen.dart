import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/availability_card_widget.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/booking_tile_widget.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/dashboard_empty_state_widget.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/dashboard_header_widget.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/dashboard_section_header_widget.dart';
import 'package:physioghar/features/dashboard/presentation/widgets/dashboard_summary_card_widget.dart';
import 'package:physioghar/features/profile/data/models/response/profile.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    final profileState = ref.watch(profileControllerProvider);
    final profile = profileState.valueOrNull;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardControllerProvider.notifier).reload(),
        child: dashboardState.when(
          loading: () => const AppLoadingWidget.small(),
          error: (error, _) => _DashboardError(
            error: error,
            onRetry: () =>
                ref.read(dashboardControllerProvider.notifier).reload(),
          ),
          data: (data) => _DashboardContent(profile: profile, data: data),
        ),
      ),
    );
  }
}

class _DashboardContent extends ConsumerStatefulWidget {
  const _DashboardContent({required this.profile, required this.data});

  final Profile? profile;
  final DashboardData data;

  @override
  ConsumerState<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends ConsumerState<_DashboardContent> {
  bool _isUpdatingAvailability = false;

  Future<void> _changeAvailability(bool value) async {
    setState(() => _isUpdatingAvailability = true);
    final error = await ref
        .read(dashboardControllerProvider.notifier)
        .setAvailability(value);
    if (!mounted) return;
    setState(() => _isUpdatingAvailability = false);
    if (error != null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: DashboardController.errorMessage(error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final bookings = widget.data.bookings;
    final todayBookings = bookings
        .where((booking) => _sameDate(booking.slotDate, today))
        .toList();
    final upcoming = bookings
        .where(
          (booking) =>
              booking.status == 'accepted' &&
              !booking.slotDate.isBefore(
                DateTime(today.year, today.month, today.day),
              ),
        )
        .toList();
    final pendingCount = bookings
        .where((item) => item.status == 'pending')
        .length;
    final completedCount = bookings
        .where((item) => item.status == 'completed')
        .length;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingLg,
        AppDimensions.pagePadding,
        AppDimensions.spacingXxl,
      ),
      children: [
        DashboardHeaderWidget(
          profile: widget.profile,
          date: formatShortDate(today),
        ),
        const SizedBox(height: AppDimensions.sectionGap),
        AvailabilityCardWidget(
          isAvailable: widget.data.availability.isAvailable,
          isLoading: _isUpdatingAvailability,
          onChanged: _changeAvailability,
        ),
        const SizedBox(height: AppDimensions.sectionGap),
        Row(
          children: [
            DashboardSummaryCardWidget(
              label: "Today's sessions",
              value: todayBookings.length,
              icon: Icons.event_available_outlined,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppDimensions.gridGap),
            DashboardSummaryCardWidget(
              label: 'Requests',
              value: pendingCount,
              icon: Icons.inbox_outlined,
              color: AppColors.accent,
            ),
            const SizedBox(width: AppDimensions.gridGap),
            DashboardSummaryCardWidget(
              label: 'Completed',
              value: completedCount,
              icon: Icons.check_circle_outline,
              color: AppColors.success,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.sectionGap),
        const DashboardSectionHeaderWidget(title: "Today's schedule"),
        const SizedBox(height: AppDimensions.spacingMd),
        if (todayBookings.isEmpty)
          const DashboardEmptyStateWidget(
            message: 'No sessions scheduled for today.',
          )
        else
          ...todayBookings.map(
            (booking) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
              child: BookingTileWidget(
                booking: booking,
                onTap: () => _showBookingDetails(booking),
              ),
            ),
          ),
        const SizedBox(height: AppDimensions.spacingMd),
        const DashboardSectionHeaderWidget(title: 'Upcoming sessions'),
        const SizedBox(height: AppDimensions.spacingMd),
        if (upcoming.isEmpty)
          const DashboardEmptyStateWidget(message: 'No upcoming sessions yet.')
        else
          ...upcoming
              .take(3)
              .map(
                (booking) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.spacingMd,
                  ),
                  child: BookingTileWidget(
                    booking: booking,
                    onTap: () => _showBookingDetails(booking),
                  ),
                ),
              ),
      ],
    );
  }

  void _showBookingDetails(Booking booking) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            0,
            AppDimensions.pagePadding,
            AppDimensions.pagePadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking.patientName, style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.spacingSm),
              Text(booking.treatment, style: AppTextStyles.titleMedium),
              const SizedBox(height: AppDimensions.spacingMd),
              Text(
                '${formatShortDate(booking.slotDate)} · ${booking.startTime.substring(0, 5)} - ${booking.endTime.substring(0, 5)}',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppDimensions.spacingSm),
              Text(booking.location, style: AppTextStyles.body),
              const SizedBox(height: AppDimensions.spacingLg),
              Text('Status: ${booking.status}', style: AppTextStyles.label),
            ],
          ),
        ),
      ),
    );
  }

  bool _sameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? DashboardController.errorMessage(error as AppError)
        : 'Could not load your dashboard';
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 420,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.pagePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_outlined,
                    color: AppColors.textMuted,
                    size: 44,
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                  TextButton(
                    onPressed: onRetry,
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
