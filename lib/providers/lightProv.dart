import 'package:flutter/material.dart';

class LightProvider with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  LightProvider({ThemeMode mode = ThemeMode.system})
      : _mode = (mode == ThemeMode.dark) ? ThemeMode.dark : ThemeMode.light;
  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
