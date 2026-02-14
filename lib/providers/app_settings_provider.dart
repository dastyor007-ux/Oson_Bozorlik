import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier {
  static const _languageCodeKey = 'app_language_code';

  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedCode = prefs.getString(_languageCodeKey);
      if (storedCode == null || storedCode.isEmpty) return;
      _locale = Locale(storedCode);
      notifyListeners();
    } catch (e) {
      debugPrint('AppSettingsProvider.loadSettings error: $e');
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    _locale = Locale(languageCode);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, languageCode);
    } catch (e) {
      debugPrint('AppSettingsProvider.setLocale error: $e');
    }
  }
}
