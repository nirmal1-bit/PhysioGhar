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
import 'package:physioghar/features/auth/data/models/requests/login_request.dart';
import 'package:physioghar/features/auth/presentation/providers/auth_providers.dart';
import 'package:physioghar/features/auth/presentation/widgets/auth_page_layout.dart';
import 'package:physioghar/utils/app_utils.dart';

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

    AppUtils.showSuccessSnackbar(context: context, message: 'Welcome back');
    context.go(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return AuthPageLayout(
      eyebrow: 'PhysioGhar therapist',
      title: 'Welcome back.',
      subtitle: 'Sign in to manage your sessions and availability.',
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email,
              ],
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
                  return 'Password is required';
                }
                if (value.length < 8) return 'Use at least 8 characters';
                return null;
              },
              onFieldSubmitted: (_) => _login(),
            ),
            const VerticalSpacing(AppDimensions.spacingXl),
            AppPrimaryButton(
              label: 'Sign in',
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
          const Text('New to PhysioGhar?'),
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
