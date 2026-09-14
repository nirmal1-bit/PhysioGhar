import 'package:flutter/material.dart';
import 'package:physioghar/core/common/widgets/app_bar.dart';
import 'package:physioghar/core/common/widgets/app_spacing.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilledAppBar(title: Text(title), showLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.headingSmall),
            const VerticalSpacing(AppDimensions.spacingLg),
            Text(body, style: AppTextStyles.bodyLarge),
          ],
        ),
      ),
    );
  }
}
