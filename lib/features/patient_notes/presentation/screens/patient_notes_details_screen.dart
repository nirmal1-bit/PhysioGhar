import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_loading_widget.dart';
import 'package:physioghar/core/common/widgets/app_empty_state.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient.dart';
import 'package:physioghar/features/patient_notes/data/models/response/patient_note.dart';
import 'package:physioghar/features/patient_notes/presentation/providers/patient_notes_providers.dart';
import 'package:physioghar/features/patient_notes/presentation/widgets/patient_note_card_widget.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/utils/date_utils.dart';

class PatientNotesDetailsScreen extends ConsumerWidget {
  const PatientNotesDetailsScreen({required this.patientId, super.key});

  final int patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientNotesDetailsProvider(patientId));
    return Scaffold(
      appBar: AppBar(title: const Text('Patient details')),
      body: state.when(
        loading: () => const AppLoadingWidget.small(),
        error: (error, _) => _DetailsError(
          error: error,
          onRetry: () => ref.invalidate(patientNotesDetailsProvider(patientId)),
        ),
        data: (patient) => _PatientDetailsContent(patient: patient),
      ),
    );
  }
}

class _PatientDetailsContent extends ConsumerWidget {
  const _PatientDetailsContent({required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eligibleSessions = patient.sessions
        .where(
          (session) =>
              session.status == 'accepted' || session.status == 'completed',
        )
        .toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingLg,
        AppDimensions.pagePadding,
        AppDimensions.spacingXxl,
      ),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primarySurface,
              foregroundColor: AppColors.primary,
              child: Text(
                patient.name.substring(0, 1).toUpperCase(),
                style: AppTextStyles.titleLarge,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patient.name, style: AppTextStyles.headingSmall),
                  Text(patient.condition, style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.sectionGap),
        _PatientSummaryCard(patient: patient),
        const SizedBox(height: AppDimensions.sectionGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Session notes', style: AppTextStyles.titleLarge),
            AppPrimaryButton(
              label: 'Add note',
              icon: Icons.add,
              onPressed: eligibleSessions.isEmpty
                  ? null
                  : () =>
                        _openNoteForm(context, ref, sessions: eligibleSessions),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        if (patient.notes.isEmpty)
          AppEmptyState(
            icon: eligibleSessions.isEmpty
                ? Icons.event_busy_outlined
                : Icons.note_add_outlined,
            title: eligibleSessions.isEmpty
                ? 'No eligible session yet'
                : 'No notes added yet',
            message: eligibleSessions.isEmpty
                ? 'Notes can be added after a session is accepted or completed.'
                : 'Add a note after the session to keep this patient\'s care history up to date.',
            compact: true,
          )
        else
          ...patient.notes.map(
            (note) => PatientNoteCardWidget(
              note: note,
              onEdit:
                  eligibleSessions.any(
                    (session) => session.bookingId == note.bookingId,
                  )
                  ? () => _openNoteForm(
                      context,
                      ref,
                      note: note,
                      sessions: eligibleSessions,
                    )
                  : null,
            ),
          ),
      ],
    );
  }

  Future<void> _openNoteForm(
    BuildContext context,
    WidgetRef ref, {
    PatientNote? note,
    required List<PatientSession> sessions,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (_) => _PatientNoteFormDialog(
        patient: patient,
        note: note,
        sessions: sessions,
      ),
    );
  }
}

class _PatientNoteFormDialog extends ConsumerStatefulWidget {
  const _PatientNoteFormDialog({
    required this.patient,
    required this.sessions,
    this.note,
  });

  final Patient patient;
  final PatientNote? note;
  final List<PatientSession> sessions;

  @override
  ConsumerState<_PatientNoteFormDialog> createState() =>
      _PatientNoteFormDialogState();
}

class _PatientNoteFormDialogState
    extends ConsumerState<_PatientNoteFormDialog> {
  late final TextEditingController _noteController;
  late final TextEditingController _exercisesController;
  late final TextEditingController _nextSessionController;
  final _formKey = GlobalKey<FormState>();
  late int _selectedBookingId;
  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.note?.note);
    _exercisesController = TextEditingController(text: widget.note?.exercises);
    _nextSessionController = TextEditingController(
      text: widget.note?.nextSession,
    );
    _selectedBookingId =
        widget.note?.bookingId ?? widget.sessions.first.bookingId;
  }

  @override
  void dispose() {
    _noteController.dispose();
    _exercisesController.dispose();
    _nextSessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.note == null ? 'Add session note' : 'Edit session note',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: _noteController,
                label: 'Session note',
                hint: 'What did the patient report?',
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                maxLength: 10000,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Add a session note'
                    : null,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              DropdownButtonFormField<int>(
                initialValue: _selectedBookingId,
                decoration: const InputDecoration(labelText: 'Session'),
                items: widget.sessions
                    .map(
                      (session) => DropdownMenuItem<int>(
                        value: session.bookingId,
                        child: Text(
                          '${formatShortDate(session.slotDate)} · ${session.treatment}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: widget.note == null
                    ? (value) {
                        if (value != null) {
                          setState(() => _selectedBookingId = value);
                        }
                      }
                    : null,
                validator: (value) => value == null ? 'Select a session' : null,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _exercisesController,
                label: 'Exercises',
                hint: 'Exercises or recommendations',
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              AppTextField(
                controller: _nextSessionController,
                label: 'Next session',
                hint: 'Plan for the next session',
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        AppPrimaryButton(label: 'Save', isLoading: _isSaving, onPressed: _save),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    AppUtils.hideKeyboard();
    setState(() => _isSaving = true);
    final error = await ref
        .read(patientNotesProvider.notifier)
        .saveNote(
          patientId: widget.patient.id,
          noteId: widget.note?.id,
          note: _noteController.text,
          exercises: _exercisesController.text,
          nextSession: _nextSessionController.text,
          bookingId: _selectedBookingId,
        );
    if (!mounted) return;
    if (error != null) {
      setState(() => _isSaving = false);
      AppUtils.showErrorSnackbar(
        context: context,
        message: PatientNotesController.errorMessage(error),
      );
      return;
    }
    Navigator.pop(context, true);
  }
}

class _PatientSummaryCard extends StatelessWidget {
  const _PatientSummaryCard({required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          children: [
            _InfoRow(
              label: 'Age',
              value: patient.age == null
                  ? 'Not provided'
                  : '${patient.age} years',
            ),
            _InfoRow(label: 'Gender', value: patient.gender ?? 'Not provided'),
            _InfoRow(label: 'Email', value: patient.email ?? 'Not provided'),
            _InfoRow(label: 'Phone', value: patient.phone ?? 'Not provided'),
            if (patient.lastSessionDate != null)
              _InfoRow(
                label: 'Last session',
                value: formatShortDate(patient.lastSessionDate!),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 90, child: Text(label, style: AppTextStyles.label)),
          Expanded(child: Text(value, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}

class _DetailsError extends StatelessWidget {
  const _DetailsError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppError
        ? PatientNotesController.errorMessage(error as AppError)
        : 'Could not load patient details';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.spacingLg),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
