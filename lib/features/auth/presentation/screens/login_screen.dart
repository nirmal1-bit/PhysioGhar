import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/api/error/app_error.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_button.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/extensions/string_extensions.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/features/auth/data/models/requests/login_request.dart';
import 'package:physioghar/features/auth/presentation/providers/auth_providers.dart';
import 'package:physioghar/features/auth/presentation/widgets/auth_page_layout.dart';
import 'package:physioghar/features/profile/presentation/providers/profile_providers.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/l10n/generated/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    AppUtils.hideKeyboard();
    final l10n = AppLocalizations.of(context)!;

    final error = await ref
        .read(authControllerProvider.notifier)
        .login(
          LoginRequest(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
    if (!mounted) return;

    if (error != null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: AuthController.errorMessage(error),
      );
      return;
    }

    AppUtils.showSuccessSnackbar(context: context, message: l10n.welcomeBack);
    final authToken = await ref.read(authControllerProvider.future);
    if (authToken?.userType == 'patient') {
      if (mounted) context.go(AppRoutes.patientHome);
      return;
    }
    try {
      // Profile data belongs to the previous session unless it is explicitly
      // refreshed. The new therapist token must be used for this request.
      ref.invalidate(profileControllerProvider);
      final profile = await ref.read(profileControllerProvider.future);
      if (!mounted) return;
      context.go(profile == null ? AppRoutes.profileEdit : AppRoutes.main);
    } on AppError catch (profileError) {
      if (!mounted) return;
      AppUtils.showErrorSnackbar(
        context: context,
        message: ProfileController.errorMessage(profileError),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final l10n = AppLocalizations.of(context)!;

    return AuthPageLayout(
      eyebrow: l10n.loginEyebrow,
      title: l10n.loginTitle,
      subtitle: l10n.loginSubtitle,
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _emailController,
              label: l10n.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email,
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.emailRequired;
                }
                if (!value.isValidEmail) return l10n.validEmail;
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _passwordController,
              label: l10n.password,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.passwordRequired;
                }
                if (value.length < 8) return l10n.minimumPassword;
                return null;
              },
              onFieldSubmitted: (_) => _login(),
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppPrimaryButton(
              label: l10n.signIn,
              onPressed: _login,
              isLoading: isLoading,
              expanded: true,
            ),
          ],
        ),
      ),
      footer: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.noAccount),
          AppTextButton(
            label: 'Create account',
            onPressed: isLoading
                ? null
                : () => context.push(AppRoutes.register),
          ),
        ],
      ),
    );
  }
}
