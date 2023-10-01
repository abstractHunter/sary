import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sary/l10n/l10n.dart';
import 'package:sary/view_models/settings_view_model.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsViewModel settingsViewModel = context.watch<SettingsViewModel>();
    var lang = settingsViewModel.locale ?? Localizations.localeOf(context);

    return DropdownButton(
      value: lang,
      onChanged: (Locale? val) {
        settingsViewModel.setLocale(val!);
      },
      items: L10n.all
          .map((e) => DropdownMenuItem(
                value: e,
                child: _buildFlag(e),
              ))
          .toList(),
    );
  }

  Widget _buildFlag(Locale locale) {
    final flag = L10n.getFlag(locale.languageCode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(flag),
        Text(locale.languageCode.toUpperCase()),
      ],
    );
  }
}
