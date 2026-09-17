import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_primary_button.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

/// A reusable empty state for lists and sections across the app.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.iconColor,
    this.iconBackgroundColor,
    this.titleColor,
    this.messageColor,
    this.backgroundColor,
    this.showIconBackground = true,
    this.compact = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? backgroundColor;
  final bool showIconBackground;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIconBackground)
          DecoratedBox(
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(compact ? 14 : 18),
              child: Icon(
                icon,
                size: compact ? 25 : 32,
                color: iconColor ?? AppColors.primary,
              ),
            ),
          )
        else
          Icon(
            icon,
            size: compact ? 25 : 32,
            color: iconColor ?? AppColors.primary,
          ),
        SizedBox(
          height: compact ? AppDimensions.spacingMd : AppDimensions.spacingLg,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleMedium.copyWith(color: titleColor),
        ),
        if (message != null) ...[
          const SizedBox(height: AppDimensions.spacingXs),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              message!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(color: messageColor),
            ),
          ),
        ],
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: AppDimensions.spacingLg),
          AppPrimaryButton(label: actionLabel!, onPressed: onAction),
        ],
      ],
    );

    if (compact) return content;

    return Card(
      color: backgroundColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXl),
        child: content,
      ),
    );
  }
}
