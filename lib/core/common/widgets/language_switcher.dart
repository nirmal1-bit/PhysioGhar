import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physioghar/core/providers/locale_provider.dart';
import 'package:physioghar/core/theme/app_colors.dart';
import 'package:physioghar/core/theme/app_dimensions.dart';
import 'package:physioghar/core/theme/app_text_styles.dart';
import 'package:physioghar/l10n/generated/app_localizations.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale =
        ref.watch(localeControllerProvider).valueOrNull ??
        Localizations.localeOf(context);
    final isNepali = locale.languageCode == 'ne';
    final localizations = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton<String>(
        tooltip: localizations.appLanguage,
        offset: const Offset(0, 8),
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        elevation: 4,
        onSelected: (languageCode) {
          ref
              .read(localeControllerProvider.notifier)
              .setLocale(Locale(languageCode));
        },
        itemBuilder: (context) => [
          _languageItem(
            languageCode: 'ne',
            flag: '🇳🇵',
            label: localizations.nepali,
            selected: isNepali,
          ),
          _languageItem(
            languageCode: 'en',
            flag: '🇺🇸',
            label: localizations.english,
            selected: !isNepali,
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
            border: Border.all(color: AppColors.primarySurface),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isNepali ? '🇳🇵' : '🇺🇸',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 7),
              Text(
                isNepali ? localizations.nepali : localizations.english,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _languageItem({
    required String languageCode,
    required String flag,
    required String label,
    required bool selected,
  }) {
    return PopupMenuItem<String>(
      value: languageCode,
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 19)),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          if (selected)
            const Icon(Icons.check_rounded, size: 18, color: AppColors.primary),
        ],
      ),
    );
  }
}
