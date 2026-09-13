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

    final error = await ref
        .read(authControllerProvider.notifier)
        .register(
          RegisterRequest(
            name: _nameController.text.trim(),
            username: _usernameController.text.trim(),
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

    AppUtils.showSuccessSnackbar(
      context: context,
      message: 'Account created. Please sign in.',
    );
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return AuthPageLayout(
      eyebrow: 'Join PhysioGhar',
      title: 'Create your account.',
      subtitle: 'Set up your therapist account to get started.',
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _nameController,
              label: 'Full name',
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                if (value.trim().length < 2) return 'Enter your full name';
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _usernameController,
              label: 'Username',
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username is required';
                }
                if (value.trim().length < 3) return 'Use at least 3 characters';
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!value.isValidEmail) return 'Enter a valid email';
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _passwordController,
              label: 'Password',
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
                  return 'Password is required';
                }
                if (value.length < 8) return 'Use at least 8 characters';
                return null;
              },
            ),
            const VerticalSpacing(AppDimensions.spacingLg),
            AppTextField(
              controller: _confirmPasswordController,
              label: 'Confirm password',
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
                  return 'Passwords do not match';
                }
                return null;
              },
              onFieldSubmitted: (_) => _register(),
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppPrimaryButton(
              label: 'Create account',
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
          const Text('Already have an account?'),
          AppTextButton(
            label: 'Sign in',
            onPressed: isLoading ? null : () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
