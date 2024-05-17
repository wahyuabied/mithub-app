import 'package:flutter/material.dart';

extension RouterExt on BuildContext {
  /// Pop all widget that pushed using imperative API [Navigator.push]
  /// Until go router page is found
  void popAllImperative({
    bool rootNavigator = false,
  }) {
    Navigator.of(this, rootNavigator: rootNavigator)
        .popUntil((route) => route.settings is Page);
  }
}
