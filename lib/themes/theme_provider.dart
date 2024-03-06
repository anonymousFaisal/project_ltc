import 'package:flutter/material.dart';
import 'package:project_ltc/themes/dark_theme.dart';
import 'package:project_ltc/themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkTheme) {
      themeData = lightTheme;
    } else {
      themeData = darkTheme;
    }
  }
}
