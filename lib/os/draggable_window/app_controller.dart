import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/providers/apps.dart';

class AppController extends ChangeNotifier {
  double top = 60;
  double left = 0;
  double height = 400;
  double width = 400;

  /// APP data
  final App app;

  double get minWidth => app.minWidth;

  double get minHeight => app.minHeight;

  double get appBarHeight => app.appBarHeight;

  /// border padding for resizing
  final double resizeBorderWidth = kIsWeb ? 8 : 15;

  AppController({
    required this.app,
    double initialWidth = 900,
    double initialHeight = 720,
  }) {
    width = initialWidth;
    height = initialHeight;
    left = 100; // todo center of screen
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
        final w = width - dx;
        if (width == minWidth && dx > 0) return;
        if (w < minWidth) {
          width = minWidth;
          left += dx - (width - w);
          return;
        }
        width = w;
        left += dx;
        notifyListeners();
      }
      if (isUpdateHeightFromStart) {
        final h = height - dy;
        if (height == minHeight && dy > 0) return;
        if (h < minHeight) {
          height = minHeight;
          top += dy - (height - h);
          return;
        }
        height -= dy;
        top += dy;

        notifyListeners();
      }
      if (isUpdateWidthFromEnd) {
        final w = width + dx;
        if (width == minWidth && dx < 0) return;
        if (w < minWidth) {
          width = minWidth;
          return;
        }
        width += dx;
        notifyListeners();
      }
      if (isUpdateHeightFromEnd) {
        final h = height + dy;
        if (height == minHeight && dy < 0) return;
        if (h < minHeight) {
          height = minHeight;
          return;
        }
        height += dy;
        notifyListeners();
      }
    } else if (isAppbarDrag) {
      top += dy;
      left += dx;
      notifyListeners();
    }
  }
}
