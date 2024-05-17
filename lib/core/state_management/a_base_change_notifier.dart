import 'package:flutter/material.dart';

/// Base class for provider [ChangeNotifier] in amartha
abstract class ABaseChangeNotifier extends ChangeNotifier {
  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
