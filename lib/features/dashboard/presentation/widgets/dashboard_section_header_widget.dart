import 'package:flutter/material.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class DashboardSectionHeaderWidget extends StatelessWidget {
  const DashboardSectionHeaderWidget({
    required this.title,
    this.action,
    super.key,
  });

  final String title;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.titleLarge)),
        if (action != null)
          TextButton(onPressed: action, child: const Text('See all')),
      ],
    );
  }
}
