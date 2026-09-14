import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:physioghar/core/providers/core_providers.dart';
import 'package:physioghar/core/router/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkSessionAndNavigate(),
    );
  }

  Future<void> _checkSessionAndNavigate() async {
    final sessionService = await ref.read(sessionServiceProvider.future);

    final hasSession = sessionService.hasSession;

    if (!mounted) return;

    if (hasSession) {
      context.replace(AppRoutes.main);
    } else {
      context.replace(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
