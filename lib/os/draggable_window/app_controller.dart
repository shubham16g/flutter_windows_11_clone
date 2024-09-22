import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/providers/apps.dart';

class AppController extends ChangeNotifier {
  double top = 60;
  double left = 0;
  double height = 400;
  double width = 400;
  double _top = 60;
  double _left = 0;
  double _height = 400;
  double _width = 400;

  /// APP data
  final App app;

  double get minWidth => app.minWidth;

  double get minHeight => app.minHeight;

  double get appBarHeight => app.appBarHeight;

  /// border padding for resizing
  final double resizeBorderWidth = kIsWeb ? 8 : 15;

  AppController({
    required this.app,
    double initialWidth = 700,
    double initialHeight = 520,
  }) {
    _width = initialWidth;
    width = initialWidth;
    _height = initialHeight;
    height = initialHeight;
    _left = 100; // todo center of screen
    left = 100; // todo center of screen
    _top = 100;
    top = 100;
  }

  bool isUpdateWidthFromStart = false;
  bool isUpdateHeightFromStart = false;
  bool isUpdateWidthFromEnd = false;
  bool isUpdateHeightFromEnd = false;
  bool isAppbarDrag = false;

  bool isDragging = false;

  MouseCursor cursor = MouseCursor.defer;

  void panStart(DragDownDetails details) {
    isUpdateWidthFromStart = details.localPosition.dx < resizeBorderWidth;
    isUpdateHeightFromStart = details.localPosition.dy < resizeBorderWidth;
    isUpdateWidthFromEnd = details.localPosition.dx > width - resizeBorderWidth;
    isUpdateHeightFromEnd =
        details.localPosition.dy > height - resizeBorderWidth;
    isAppbarDrag = details.localPosition.dy < appBarHeight;
    isDragging = true;
  }

  void panEnd(Size screenSize) {
    isUpdateWidthFromStart = false;
    isUpdateHeightFromStart = false;
    isUpdateWidthFromEnd = false;
    isUpdateHeightFromEnd = false;
    isAppbarDrag = false;
    isDragging = false;

    if (left + width < 30) {
      left = -width + 30;
    }
    if (top < 60) {
      top = 60;
    }
    if (left > screenSize.width - 30) {
      left = screenSize.width - 30;
    }
    if (top > screenSize.height - 30) {
      top = screenSize.height - 30;
    }
    if (width < minWidth) {
      width = minWidth;
    }
    if (height < minHeight) {
      height = minHeight;
    }
    _width = width;
    _height = height;
    _left = left;
    _top = top;
    notifyListeners();
  }

  void onHover(PointerHoverEvent details) {
    if (details.localPosition.dx < resizeBorderWidth ||
        details.localPosition.dy < resizeBorderWidth ||
        details.localPosition.dx > width - resizeBorderWidth ||
        details.localPosition.dy > height - resizeBorderWidth) {
      cursor = SystemMouseCursors.precise;
      notifyListeners();
    } else {
      cursor = MouseCursor.defer;
      notifyListeners();
    }
  }

  void onPanUpdate(double dx, double dy, double localDx, double localDy) {
    debugPrint('dx: $dx, dy: $dy, localDx: $localDx, localDy: $localDy');
    if (isUpdateWidthFromStart ||
        isUpdateHeightFromStart ||
        isUpdateWidthFromEnd ||
        isUpdateHeightFromEnd) {
      if (isUpdateWidthFromStart) {
        _width -= dx;
        _left += dx;
        if (_width < minWidth) {
          final diff = width - minWidth;
          width = minWidth;
          left += diff;
          notifyListeners();
          return;
        }
        width = _width;
        left = _left;
        notifyListeners();
      }
      if (isUpdateHeightFromStart) {
        _height -= dy;
        _top += dy;
        if (_height < minHeight) {
          final diff = height - minHeight;
          height = minHeight;
          top += diff;
          notifyListeners();
          return;
        }
        height = _height;
        top = _top;
        notifyListeners();
      }
      if (isUpdateWidthFromEnd) {
        _width += dx;
        if (_width < minWidth) {
          width = minWidth;
          notifyListeners();
          return;
        }
        width = _width;
        notifyListeners();
      }
      if (isUpdateHeightFromEnd) {
        _height += dy;
        if (_height < minHeight) {
          height = minHeight;
          notifyListeners();
          return;
        }
        height = _height;
        notifyListeners();
      }
    } else if (isAppbarDrag) {
      _top += dy;
      _left += dx;
      top = _top;
      left = _left;
      notifyListeners();
    }
  }
}
