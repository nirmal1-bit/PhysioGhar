import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppUtils {
  static Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 85,
    double maxWidth = 1200,
  }) {
    return ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality,
      maxWidth: maxWidth,
    );
  }

  static void unfocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Dismisses the active keyboard without requiring a widget context.
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> confirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Future<void> Function() onConfirm,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(true);
                await onConfirm();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static void showErrorSnackbar({
    String message = 'Invalid Url',
    void Function()? onRetry,
    String buttonText = 'Retry',
    BuildContext? context,
  }) {
    if (context != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
          backgroundColor: AppColors.error,
          textStyle: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
      return;
    }
  }

  static void showSuccessSnackbar({
    String message = 'Success',
    void Function()? onAction,
    String actionText = 'OK',
    BuildContext? context,
  }) {
    if (context != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          backgroundColor: AppColors.success,
          textStyle: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
      return;
    }
  }
}
