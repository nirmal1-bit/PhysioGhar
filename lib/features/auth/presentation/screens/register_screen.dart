import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/common/widgets/app_text_button.dart';
import 'package:physioghar/core/common/widgets/app_text_field.dart';
import 'package:physioghar/core/extensions/string_extensions.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/features/auth/data/models/requests/register_request.dart';
import 'package:physioghar/features/auth/presentation/providers/auth_providers.dart';
import 'package:physioghar/features/auth/presentation/widgets/auth_page_layout.dart';
import 'package:physioghar/utils/app_utils.dart';
import 'package:physioghar/l10n/generated/app_localizations.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;
  String _userType = 'therapist';

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    AppUtils.hideKeyboard();
    final l10n = AppLocalizations.of(context)!;

    final error = await ref
        .read(authControllerProvider.notifier)
        .register(
          RegisterRequest(
            name: _nameController.text.trim(),
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            userType: _userType,
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

    AppUtils.showSuccessSnackbar(
      context: context,
      message: l10n.accountCreated,
    );
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final l10n = AppLocalizations.of(context)!;

    return AuthPageLayout(
      eyebrow: l10n.registerEyebrow,
      title: l10n.registerTitle,
      subtitle: l10n.registerSubtitle,
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _nameController,
              label: l10n.fullName,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.nameRequired;
                }
                if (value.trim().length < 2) return l10n.fullNameRequired;
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _usernameController,
              label: l10n.username,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.usernameRequired;
                }
                if (value.trim().length < 3) return l10n.minimumUsername;
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _emailController,
              label: l10n.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
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
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _confirmPasswordController,
              label: l10n.confirmPassword,
              obscureText: _obscureConfirmation,
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureConfirmation = !_obscureConfirmation;
                  });
                },
                icon: Icon(
                  _obscureConfirmation
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              validator: (value) {
                if (value != _passwordController.text) {
                  return l10n.passwordsMismatch;
                }
                return null;
              },
              onFieldSubmitted: (_) => _register(),
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            DropdownButtonFormField<String>(
              initialValue: _userType,
              decoration: InputDecoration(labelText: l10n.accountType),
              items: [
                DropdownMenuItem(
                  value: 'therapist',
                  child: Text(l10n.therapist),
                ),
                DropdownMenuItem(value: 'patient', child: Text(l10n.patient)),
              ],
              onChanged: isLoading
                  ? null
                  : (value) {
                      if (value != null) setState(() => _userType = value);
                    },
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppPrimaryButton(
              label: l10n.createAccount,
              onPressed: _register,
              isLoading: isLoading,
              expanded: true,
            ),
          ],
        ),
      ),
      footer: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.alreadyHaveAccount),
          AppTextButton(
            label: l10n.signInAction,
            onPressed: isLoading ? null : () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
