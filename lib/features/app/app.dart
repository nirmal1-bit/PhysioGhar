import 'package:flutter/material.dart';
import 'package:physioghar/core/router/app_router.dart';
import 'package:physioghar/core/theme/app_theme.dart';

class PhysioGharApp extends StatelessWidget {
  const PhysioGharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PhysioGhar Therapist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
