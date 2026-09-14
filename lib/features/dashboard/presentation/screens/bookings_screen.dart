import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/dashboard/data/models/response/booking.dart';
import 'package:physioghar/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:physioghar/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    return SafeArea(
      child: state.when(
        loading: () => const AppLoadingWidget.small(),
        error: (error, _) => _BookingsError(
          error: error,
          onRetry: () =>
              ref.read(dashboardControllerProvider.notifier).reload(),
        ),
        data: (data) => _BookingsContent(bookings: data.bookings),
      ),
    );
  }
}

class _BookingsContent extends ConsumerStatefulWidget {
  const _BookingsContent({required this.bookings});

  final List<Booking> bookings;

  @override
  ConsumerState<_BookingsContent> createState() => _BookingsContentState();
}

class _BookingsContentState extends ConsumerState<_BookingsContent> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePadding,
              AppDimensions.spacingLg,
              AppDimensions.pagePadding,
              AppDimensions.spacingMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bookings', style: AppTextStyles.headingSmall),
                const SizedBox(height: AppDimensions.spacingXs),
                Text(
                  'Manage requests, sessions, and patient records.',
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textMuted,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Requests'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _BookingList(
                  bookings: _byStatus('pending'),
                  emptyMessage: 'No new booking requests.',
                  onTap: _showBookingDetails,
                ),
                _BookingList(
                  bookings: _byStatus('accepted'),
                  emptyMessage: 'No upcoming sessions.',
                  onTap: _showBookingDetails,
                ),
                _BookingList(
                  bookings: _byStatus('completed'),
                  emptyMessage: 'Completed sessions will appear here.',
                  onTap: _showBookingDetails,
                ),
                _BookingList(
                  bookings: [
                    ..._byStatus('declined'),
                    ..._byStatus('cancelled'),
                  ],
                  emptyMessage: 'No cancelled bookings.',
                  onTap: _showBookingDetails,
                ),
              ],
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(minHeight: 2),
        ],
      ),
    );
  }

  List<Booking> _byStatus(String status) =>
      widget.bookings.where((booking) => booking.status == status).toList();

  Future<void> _showBookingDetails(Booking booking) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _BookingDetailsSheet(
        booking: booking,
        onAccept: booking.status == 'pending'
            ? () => _changeStatus(booking, 'accepted', sheetContext)
            : null,
        onDecline: booking.status == 'pending'
            ? () => _changeStatus(booking, 'declined', sheetContext)
            : null,
        onComplete: booking.status == 'accepted'
            ? () => _changeStatus(booking, 'completed', sheetContext)
            : null,
        onCancel: booking.status == 'accepted'
            ? () => _changeStatus(booking, 'cancelled', sheetContext)
            : null,
        onReschedule:
            booking.status == 'pending' || booking.status == 'accepted'
            ? () => _reschedule(booking, sheetContext)
            : null,
        onNotes: booking.status != 'declined' && booking.status != 'cancelled'
            ? () => _editNotes(booking, sheetContext)
            : null,
      ),
    );
  }

  Future<void> _changeStatus(
    Booking booking,
    String status,
    BuildContext sheetContext,
  ) async {
    Navigator.of(sheetContext).pop();
    setState(() => _isLoading = true);
    final error = await ref
        .read(dashboardControllerProvider.notifier)
        .updateBookingStatus(bookingId: booking.id, status: status);
    if (!mounted) return;
    setState(() => _isLoading = false);
    _showError(error);
  }

  Future<void> _editNotes(Booking booking, BuildContext sheetContext) async {
    Navigator.of(sheetContext).pop();
    final controller = TextEditingController(
      text: booking.therapistNotes ?? '',
    );
    final notes = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Therapist notes'),
        content: TextField(
          controller: controller,
          maxLines: 6,
          maxLength: 5000,
          decoration: const InputDecoration(
            hintText: 'Add remarks about this patient or session',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, controller.text.trim()),
            child: const Text('Save notes'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (notes == null || !mounted) return;
    setState(() => _isLoading = true);
    final error = await ref
        .read(dashboardControllerProvider.notifier)
        .updateBookingNotes(bookingId: booking.id, notes: notes);
    if (!mounted) return;
    setState(() => _isLoading = false);
    _showError(error);
  }

  Future<void> _reschedule(Booking booking, BuildContext sheetContext) async {
    Navigator.of(sheetContext).pop();
    try {
      final schedule = await ref.read(scheduleControllerProvider.future);
      final openSlots = schedule.schedule.slots
          .where((slot) => slot.status == 'open' && slot.id != booking.slotId)
          .toList();
      if (!mounted) return;
      if (openSlots.isEmpty) {
        AppUtils.showErrorSnackbar(
          context: context,
          message: 'No open slots are available to reschedule this session.',
        );
        return;
      }
      final selectedSlotId = await showModalBottomSheet<int>(
        context: context,
        showDragHandle: true,
        builder: (context) => SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.pagePadding,
              0,
              AppDimensions.pagePadding,
              AppDimensions.pagePadding,
            ),
            children: [
              Text('Choose a new time', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.spacingMd),
              for (final slot in openSlots)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: Text(formatShortDate(slot.slotDate)),
                  subtitle: Text(
                    '${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}',
                  ),
                  onTap: () => Navigator.pop(context, slot.id),
                ),
            ],
          ),
        ),
      );
      if (selectedSlotId == null || !mounted) return;
      setState(() => _isLoading = true);
      final error = await ref
          .read(dashboardControllerProvider.notifier)
          .rescheduleBooking(bookingId: booking.id, slotId: selectedSlotId);
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(error);
      if (error == null) {
        await ref.read(scheduleControllerProvider.notifier).reload();
      }
    } catch (error) {
      if (mounted) {
        AppUtils.showErrorSnackbar(
          context: context,
          message: 'Could not load open slots',
        );
      }
    }
  }

  void _showError(AppError? error) {
    if (error != null && mounted) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: DashboardController.errorMessage(error),
      );
    }
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({
    required this.bookings,
    required this.emptyMessage,
    required this.onTap,
  });

  final List<Booking> bookings;
  final String emptyMessage;
  final ValueChanged<Booking> onTap;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.pagePadding),
          child: Text(emptyMessage, style: AppTextStyles.bodySmall),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingLg,
        AppDimensions.pagePadding,
        AppDimensions.spacingXxl,
      ),
      itemCount: bookings.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppDimensions.spacingMd),
      itemBuilder: (context, index) => _BookingCard(
        booking: bookings[index],
        onTap: () => onTap(bookings[index]),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking, required this.onTap});

  final Booking booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primarySurface,
                child: Text(
                  booking.patientName.substring(0, 1).toUpperCase(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.patientName, style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppDimensions.spacingXs),
                    Text(booking.treatment, style: AppTextStyles.bodySmall),
                    const SizedBox(height: AppDimensions.spacingXs),
                    Text(
                      '${formatShortDate(booking.slotDate)} · ${booking.startTime.substring(0, 5)}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              _StatusPill(status: booking.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isPositive = status == 'accepted' || status == 'completed';
    final isPending = status == 'pending';
    final color = isPending
        ? AppColors.accent
        : isPositive
        ? AppColors.success
        : AppColors.error;
    final background = isPending
        ? AppColors.accentSurface
        : isPositive
        ? AppColors.primarySurface
        : AppColors.errorSurface;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          status.toUpperCase(),
          style: AppTextStyles.eyebrow.copyWith(color: color, fontSize: 9),
        ),
      ),
    );
  }
}

class _BookingDetailsSheet extends StatelessWidget {
  const _BookingDetailsSheet({
    required this.booking,
    this.onAccept,
    this.onDecline,
    this.onComplete,
    this.onCancel,
    this.onReschedule,
    this.onNotes,
  });

  final Booking booking;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onNotes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.pagePadding,
          0,
          AppDimensions.pagePadding,
          AppDimensions.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.patientName, style: AppTextStyles.headingSmall),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(booking.patientEmail, style: AppTextStyles.bodySmall),
            const SizedBox(height: AppDimensions.spacingLg),
            _DetailRow(
              icon: Icons.medical_services_outlined,
              label: booking.treatment,
            ),
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: formatShortDate(booking.slotDate),
            ),
            _DetailRow(
              icon: Icons.schedule_outlined,
              label:
                  '${booking.startTime.substring(0, 5)} - ${booking.endTime.substring(0, 5)}',
            ),
            _DetailRow(
              icon: Icons.location_on_outlined,
              label: booking.location,
            ),
            _DetailRow(icon: Icons.phone_outlined, label: booking.patientPhone),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'Status: ${booking.status.toUpperCase()}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text('Therapist notes', style: AppTextStyles.label),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              booking.therapistNotes?.isNotEmpty == true
                  ? booking.therapistNotes!
                  : 'No remarks added yet.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            if (onNotes != null)
              OutlinedButton.icon(
                onPressed: onNotes,
                icon: const Icon(Icons.edit_note_outlined),
                label: Text(
                  booking.therapistNotes?.isNotEmpty == true
                      ? 'Edit notes'
                      : 'Add notes',
                ),
              ),
            if (onReschedule != null)
              OutlinedButton.icon(
                onPressed: onReschedule,
                icon: const Icon(Icons.event_repeat_outlined),
                label: const Text('Reschedule'),
              ),
            if (onAccept != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              AppPrimaryButton(
                label: 'Accept request',
                onPressed: onAccept,
                expanded: true,
              ),
            ],
            if (onComplete != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              AppPrimaryButton(
                label: 'Mark completed',
                onPressed: onComplete,
                expanded: true,
              ),
            ],
            if (onDecline != null || onCancel != null) ...[
              const SizedBox(height: AppDimensions.spacingSm),
              TextButton(
                onPressed: onDecline ?? onCancel,
                child: Text(
                  onDecline != null ? 'Decline request' : 'Cancel session',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.textMuted),
          const SizedBox(width: AppDimensions.spacingSm),
          Expanded(child: Text(label, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}

class _BookingsError extends StatelessWidget {
  const _BookingsError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? DashboardController.errorMessage(error as AppError)
        : 'Could not load bookings';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
