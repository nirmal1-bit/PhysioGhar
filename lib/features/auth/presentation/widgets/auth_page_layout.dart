import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.footer,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget form;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.pagePadding,
              vertical: AppDimensions.spacingXxl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eyebrow.toUpperCase(), style: AppTextStyles.eyebrow),
                  const VerticalSpacing(AppDimensions.spacingMd),
                  Text(title, style: AppTextStyles.headingMedium),
                  const VerticalSpacing(AppDimensions.spacingSm),
                  Text(subtitle, style: AppTextStyles.body),
                  const VerticalSpacing(AppDimensions.spacingXl),
                  form,
                  const VerticalSpacing(AppDimensions.spacingXl),
                  Center(child: footer),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
