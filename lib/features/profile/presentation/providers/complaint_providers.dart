import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/features/profile/data/models/response/complaint.dart';
import 'package:physioghar/features/profile/data/repositories/complaint_repository_impl.dart';
import 'package:physioghar/features/profile/domain/repositories/complaint_repository.dart';

final complaintRepositoryProvider = Provider<ComplaintRepository>((ref) {
  return ComplaintRepositoryImpl(
    ref.read(dioProvider),
    ref.read(networkInfoProvider),
  );
});

final complaintControllerProvider =
    AsyncNotifierProvider<ComplaintController, List<Complaint>>(
      ComplaintController.new,
    );

class ComplaintController extends AsyncNotifier<List<Complaint>> {
  @override
  Future<List<Complaint>> build() async {
    ref.watch(sessionRevisionProvider);
    final result = await ref.read(complaintRepositoryProvider).getComplaints();
    return result.fold((error) => throw error, (complaints) => complaints);
  }

  Future<AppError?> submit({
    required String category,
    required String subject,
    required String description,
  }) async {
    final result = await ref
        .read(complaintRepositoryProvider)
        .createComplaint(
          category: category,
          subject: subject,
          description: description,
        );
    return result.fold((error) => error, (complaint) {
      state = AsyncData([complaint, ...?state.valueOrNull]);
      return null;
    });
  }

  static String errorMessage(AppError error) => error.when(
    serverError: (value) => value.message,
    validationError: (value) => value.message,
    noInternet: (value) => value.message,
  );
}
