import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.size = AppDimensions.minTapTarget,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon),
      color: foregroundColor ?? AppColors.textPrimary,
      style: IconButton.styleFrom(
        minimumSize: Size.square(size),
        fixedSize: Size.square(size),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
