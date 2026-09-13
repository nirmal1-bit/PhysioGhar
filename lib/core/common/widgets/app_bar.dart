import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

/// A blank app bar for screens that do not need visible app-bar content.
class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: const SizedBox.shrink(),
    );
  }
}

/// The common visible app-bar surface used throughout the application.
class FilledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilledAppBar({
    super.key,
    this.title,
    this.leading,
    this.showLeading = false,
    this.actions,
    this.bottom,
    this.backgroundColor = AppColors.background,
    this.foregroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.toolbarHeight,
    this.leadingWidth,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.iconTheme,
    this.surfaceTintColor,
  });

  final Widget? title;
  final Widget? leading;
  final bool showLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final double scrolledUnderElevation;
  final double? toolbarHeight;
  final double? leadingWidth;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final IconThemeData? iconTheme;
  final Color? surfaceTintColor;

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Keep these values fixed so every filled app bar shares one surface.
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      surfaceTintColor: surfaceTintColor ?? Colors.transparent,
      toolbarHeight: toolbarHeight,
      leading: leading ?? (showLeading ? const BackButton() : null),
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      centerTitle: centerTitle ?? false,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: foregroundColor ?? AppColors.textPrimary,
      ),
      actions: actions,
      bottom: bottom,
      iconTheme: iconTheme,
    );
  }
}
