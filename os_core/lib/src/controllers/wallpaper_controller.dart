import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'settings/os_theme_controller.dart';

class WallpaperController extends ChangeNotifier {

  String? wallpaperPath;
  Image? blurredWallpaper;
  Color dominantColor = const Color(0xFF202020);
  final OsThemeController themeController;

  WallpaperController(this.themeController, {String? initialPath}) {
    _listenTheme();
    themeController.addListener(_listenTheme);
  }

  void _listenTheme() {
    if (themeController.isDark) {
      loadWallpaperFromAsset('assets/images/wall_dark.jpg');
    } else {
      loadWallpaperFromAsset('assets/images/wall_light.jpg');
    }
  }


  Future<void> loadWallpaperFromAsset(String path) async {
    final baseImage = await _loadBaseImage(path);
    dominantColor = await getDominantColor(baseImage);
    wallpaperPath = path;
    notifyListeners();
    // loadImageFromAsset(baseImage).then((value) {
    //   wallpaper = value;
    //   notifyListeners();
    // });
    loadImageFromAssetAndBlurIt(baseImage).then((value) {
      blurredWallpaper = value;
      notifyListeners();
    });

  }

  Future<Color> getDominantColor(ui.Image image) async {
    // final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    // final bytes = byteData!.buffer.asUint8List();
    //
    // final pixelCount = bytes.lengthInBytes ~/ 4;
    // final r = List<int>.filled(256, 0);
    // final g = List<int>.filled(256, 0);
    // final b = List<int>.filled(256, 0);
    // get brightest and primary color
   return Colors.blue;
  }

  Future<ui.Image> _loadBaseImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = Uint8List.view(data.buffer);
    return await decodeImageFromList(bytes);
  }

  Future<Image> loadImageFromAsset(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return Image.memory(buffer);
  }

  Future<Image> loadImageFromAssetAndBlurIt(ui.Image image) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..imageFilter = ui.ImageFilter.blur(sigmaX: 70, sigmaY: 70);
    canvas.drawImage(image, Offset.zero, paint);
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return Image.memory(buffer);
  }

  @override
  void dispose() {
    themeController.removeListener(_listenTheme);
    super.dispose();
  }
}
