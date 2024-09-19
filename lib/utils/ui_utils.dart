import 'package:flutter/material.dart';

extension UiBuildContextExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  ColorScheme get color => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;

}