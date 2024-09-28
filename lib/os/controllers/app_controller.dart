import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/app/apps.dart';
import 'package:flutter_windows_11_clone/os/controllers/cursor_controller.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';

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
  final CursorController cursorController;
  final RunningAppsController runningAppsController;

  AppController({
    required this.app,
    required this.cursorController,
    required this.runningAppsController,
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

    _openAppAnim();
    runningAppsController.addListener(_listenRunningApps);
  }

  void _listenRunningApps() {
    notifyListeners();
  }

  bool get isFocused => runningAppsController.isFocused(this);

  bool isUpdateWidthFromStart = false;
  bool isUpdateHeightFromStart = false;
  bool isUpdateWidthFromEnd = false;
  bool isUpdateHeightFromEnd = false;
  bool isAppbarDrag = false;

  bool isDragging = false;
  bool exitWhenStopDragging = false;

  void panStart(DragDownDetails details) {
    debugPrint('panStart');
    isUpdateWidthFromStart = details.localPosition.dx < resizeBorderWidth;
    isUpdateHeightFromStart = details.localPosition.dy < resizeBorderWidth;
    isUpdateWidthFromEnd = details.localPosition.dx > width - resizeBorderWidth;
    isUpdateHeightFromEnd =
        details.localPosition.dy > height - resizeBorderWidth;
    isAppbarDrag = details.localPosition.dy < appBarHeight;
    isDragging = true;
  }

  void panEnd(Size screenSize) {
    debugPrint('panEnd');
    isUpdateWidthFromStart = false;
    isUpdateHeightFromStart = false;
    isUpdateWidthFromEnd = false;
    isUpdateHeightFromEnd = false;
    isAppbarDrag = false;
    isDragging = false;

    if (left + width < 30) {
      left = -width + 30;
    }
    if (top < 0) {
      top = 0;
    }
    if (left > screenSize.width - 30) {
      left = screenSize.width - 30;
    }
    if (top > screenSize.height - 70) {
      top = screenSize.height - 70;
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
    if (exitWhenStopDragging) {
      cursorController.setCursor(MouseCursor.defer);
    }
  }

  void onHover(PointerHoverEvent details) {
    if (isFullScreen) {
      cursorController.setCursor(MouseCursor.defer);
      return;
    }
    exitWhenStopDragging = false;
    final atStart = details.localPosition.dx < resizeBorderWidth;
    final atEnd = details.localPosition.dx > width - resizeBorderWidth;
    final atTop = details.localPosition.dy < resizeBorderWidth;
    final atBottom = details.localPosition.dy > height - resizeBorderWidth;
    MouseCursor cursor;
    if (atStart && atTop || atEnd && atBottom) {
      cursor = SystemMouseCursors.resizeDownRight;
    } else if (atStart && atBottom || atEnd && atTop) {
      cursor = SystemMouseCursors.resizeDownLeft;
    } else if (atStart || atEnd) {
      cursor = SystemMouseCursors.resizeLeftRight;
    } else if (atTop || atBottom) {
      cursor = SystemMouseCursors.resizeUpDown;
    } else {
      cursor = MouseCursor.defer;
    }
    cursorController.setCursor(cursor);
  }

  void onHoverExit(PointerExitEvent details) {
    exitWhenStopDragging = true;
    if (isDragging) return;
    cursorController.setCursor(MouseCursor.defer);
  }

  void onHoverEnter(PointerEnterEvent details) {
    exitWhenStopDragging = false;
  }

  void onPanUpdate(double dx, double dy, double localDx, double localDy) {
    debugPrint(
        'isOpenCloseAnim: $isOpenCloseAnim, isFullScreenAnim: $isFullScreenAnim, isDragging: $isDragging');
    // debugPrint('dx: $dx, dy: $dy, localDx: $localDx, localDy: $localDy');
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

  bool isFullScreen = false;
  bool isFullScreenAnim = false;

  bool isMinimized = false;

  bool isOpenClose = true;
  bool isOpenCloseAnim = true;

  Future<void> toggleFullScreen() async {
    debugPrint('toggleFullScreen');
    isFullScreen = !isFullScreen;
    if (isFullScreen) {
      cursorController.setCursor(MouseCursor.defer);
      isFullScreenAnim = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      if (!isFullScreen) return;
      isFullScreenAnim = false;
      notifyListeners();
    } else {
      isFullScreenAnim = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      if (isFullScreen) return;
      isFullScreenAnim = false;
      notifyListeners();
    }
  }

  void toggleMinimizeMaximize() {
    debugPrint('toggleMinimizeMaximize');
    runningAppsController.toggleMinimizeMaximize(this);
  }

  Future<void> internalMaximize() async {
    if (!isMinimized) return;
    debugPrint('internalMaximize');
    isMinimized = false;
    isFullScreenAnim = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    if (isMinimized) return;
    isFullScreenAnim = false;
    notifyListeners();
  }

  Future<void> internalMinimize() async {
    if (isMinimized) return;
    debugPrint('internalMinimize');
    isMinimized = true;
    isFullScreenAnim = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!isMinimized) return;
    isFullScreenAnim = false;
    notifyListeners();
  }

  void _openAppAnim() {
    debugPrint('_openAppAnim');
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      debugPrint('_openAppAnim POST FRAME');
      isOpenClose = false;
      isOpenCloseAnim = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 200));
      if (!isOpenClose) return;
      isOpenCloseAnim = false;
      notifyListeners();
    });
  }

  Future<void> closeApp() {
    debugPrint('closeApp');
    return runningAppsController.closeApp(this);
  }

  Future<void> internalCloseAppAnim() async {
    debugPrint('internalCloseAppAnim');
    isOpenClose = true;
    isOpenCloseAnim = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    if (isOpenClose) return;
    isOpenCloseAnim = false;
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint('dispose');
    runningAppsController.removeListener(_listenRunningApps);
    super.dispose();
  }
}
