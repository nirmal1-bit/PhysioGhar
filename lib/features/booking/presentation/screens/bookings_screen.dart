import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/booking/data/models/response/booking.dart';
import 'package:physioghar/features/booking/presentation/providers/booking_providers.dart';
import 'package:physioghar/features/booking/presentation/widgets/booking_details_sheet_widget.dart';
import 'package:physioghar/features/booking/presentation/widgets/booking_error_widget.dart';
import 'package:physioghar/features/booking/presentation/widgets/booking_list_widget.dart';
import 'package:physioghar/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingControllerProvider);
    return SafeArea(
      child: state.when(
        loading: () => const AppLoadingWidget.small(),
        error: (error, _) => BookingErrorWidget(
          message: _errorMessage(error),
          onRetry: () => ref.read(bookingControllerProvider.notifier).reload(),
        ),
        data: (bookings) => _BookingsContent(bookings: bookings),
      ),
    );
  }

  String _errorMessage(Object error) {
    return error is AppError
        ? BookingController.errorMessage(error)
        : 'Could not load bookings';
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
                BookingListWidget(
                  bookings: _byStatus('pending'),
                  emptyMessage: 'No new booking requests.',
                  onTap: _showBookingDetails,
                ),
                BookingListWidget(
                  bookings: _byStatus('accepted'),
                  emptyMessage: 'No upcoming sessions.',
                  onTap: _showBookingDetails,
                ),
                BookingListWidget(
                  bookings: _byStatus('completed'),
                  emptyMessage: 'Completed sessions will appear here.',
                  onTap: _showBookingDetails,
                ),
                BookingListWidget(
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
      builder: (sheetContext) => BookingDetailsSheetWidget(
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
        .read(bookingControllerProvider.notifier)
        .updateStatus(bookingId: booking.id, status: status);
    if (!mounted) return;
    setState(() => _isLoading = false);
    _showError(error);
  }

  Future<void> _editNotes(Booking booking, BuildContext sheetContext) async {
    Navigator.of(sheetContext).pop();
    final notes = await showDialog<String>(
      context: context,
      builder: (_) =>
          _BookingNotesDialog(initialNotes: booking.therapistNotes ?? ''),
    );
    if (notes == null || !mounted) return;
    setState(() => _isLoading = true);
    final error = await ref
        .read(bookingControllerProvider.notifier)
        .updateNotes(bookingId: booking.id, notes: notes);
    if (!mounted) return;
    setState(() => _isLoading = false);
    _showError(error);
  }

  Future<void> _reschedule(Booking booking, BuildContext sheetContext) async {
    Navigator.of(sheetContext).pop();
    try {
      await ref
          .read(scheduleControllerProvider.notifier)
          .selectDate(booking.slotDate);
      final schedule = await ref.read(scheduleControllerProvider.future);
      final openSlots = schedule.schedule.slots
          .where(
            (slot) =>
                slot.status == 'open' &&
                !(slot.id == booking.slotId &&
                    _sameDate(slot.slotDate, booking.slotDate)),
          )
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
          .read(bookingControllerProvider.notifier)
          .reschedule(
            bookingId: booking.id,
            slotId: selectedSlotId,
            slotDate: openSlots
                .firstWhere((slot) => slot.id == selectedSlotId)
                .slotDate,
          );
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(error);
      if (error == null) {
        await ref.read(scheduleControllerProvider.notifier).reload();
      }
    } catch (_) {
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
        message: BookingController.errorMessage(error),
      );
    }
  }

  bool _sameDate(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

class _BookingNotesDialog extends StatefulWidget {
  const _BookingNotesDialog({required this.initialNotes});

  final String initialNotes;

  @override
  State<_BookingNotesDialog> createState() => _BookingNotesDialogState();
}

class _BookingNotesDialogState extends State<_BookingNotesDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Therapist notes'),
      content: TextField(
        controller: _controller,
        maxLines: 6,
        maxLength: 5000,
        decoration: const InputDecoration(
          hintText: 'Add remarks about this patient or session',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: const Text('Save notes'),
        ),
      ],
    );
  }
}
