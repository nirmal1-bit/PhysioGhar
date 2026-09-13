import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/features/auth/presentation/screens/login_screen.dart';
import 'package:physioghar/features/auth/presentation/screens/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Dashboard coming soon'))),
    ),
  ],
);
