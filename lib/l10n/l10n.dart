import 'package:flutter/material.dart';

class L10n {
  static const all = [
    Locale('fr'),
    Locale('en'),
    Locale('es'),
  ];

  static String getFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      default:
        return '🌐';
    }
  }
}
