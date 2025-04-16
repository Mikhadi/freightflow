import 'package:flutter/material.dart';
import 'package:freiightflow/core/constants.dart';
import 'package:freiightflow/notifiers/locale_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = localeNotifier.value.languageCode == "en";

    return ToggleButtons(
      isSelected: [isEnglish, !isEnglish],
      onPressed: (index) {
        final newLocale = index == 1 ? Locale('he') : Locale('en');
        localeNotifier.value = newLocale;
        saveLocale(newLocale.languageCode);
      },
      borderRadius: BorderRadius.circular(kRoundedBorder),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(AppLocalizations.of(context)!.english),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(AppLocalizations.of(context)!.hebrew),
        ),
      ],
    );
  }
}
