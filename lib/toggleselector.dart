import 'package:flutter/material.dart';

class ToggleSelector with ChangeNotifier {
  bool _isNarrowBody = true; // Default to NarrowBody

  bool get isNarrowBody => _isNarrowBody;

  void toggleBody() {
    _isNarrowBody = !_isNarrowBody; // Toggle between NarrowBody and WideBody
    notifyListeners();
  }
}
