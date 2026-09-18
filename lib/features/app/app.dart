import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/providers/locale_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:physioghar/core/router/app_router.dart';
import 'package:physioghar/core/theme/app_theme.dart';
import 'package:physioghar/l10n/generated/app_localizations.dart';
import 'package:physioghar/utils/app_utils.dart';

class PhysioGharApp extends ConsumerWidget {
  const PhysioGharApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider).valueOrNull;
    return GestureDetector(
      onTap: () {
        AppUtils.unfocusKeyboard(context);
      },
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          title: 'PhysioGhar Therapist',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ne')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
