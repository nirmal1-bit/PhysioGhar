import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/providers/core_providers.dart';

final localeControllerProvider =
    AsyncNotifierProvider<LocaleController, Locale>(LocaleController.new);

class LocaleController extends AsyncNotifier<Locale> {
  @override
  Future<Locale> build() async {
    final session = await ref.read(sessionServiceProvider.future);
    return Locale(session.locale);
  }

  Future<void> setLocale(Locale locale) async {
    final session = await ref.read(sessionServiceProvider.future);
    await session.saveLocale(locale.languageCode);
    state = AsyncData(locale);
  }
}
