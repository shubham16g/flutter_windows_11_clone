import 'package:flutter/material.dart';

class CursorController extends ChangeNotifier {
  MouseCursor cursor = MouseCursor.defer;

  void setCursor(MouseCursor newCursor) {
    if (cursor == newCursor) return;
    cursor = newCursor;
    debugPrint('cursor: $cursor');
    notifyListeners();
  }
}