import 'package:flutter/material.dart';

extension UiBuildContextExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Size get screenSize => MediaQuery.of(this).size;

}

extension WidgetExt on Widget {
  Widget pad({double? top, double? bottom, double? left, double? right, double? all, double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

}