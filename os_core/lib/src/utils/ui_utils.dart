import 'package:flutter/material.dart';

extension UiBuildContextExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  ColorScheme get color => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}