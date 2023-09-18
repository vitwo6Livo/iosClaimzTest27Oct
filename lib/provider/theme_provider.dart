import 'package:claimz/models/dark_theme_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
