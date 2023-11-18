import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color backgroundColor = Colors.white;

  void updateBackground(Color color) {
    backgroundColor = color;
    notifyListeners();
  }
}
