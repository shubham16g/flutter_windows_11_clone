import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class WallpaperWrapper extends ChangeNotifier {

  Image? wallpaper;
  Image? blurredWallpaper;
  Color dominantColor = const Color(0xFF202020);

  WallpaperWrapper({String? initialPath}) {
    loadWallpaperFromAsset(initialPath ?? 'assets/images/wall_dark.jpg');
  }


  Future<void> loadWallpaperFromAsset(String path) async {
    final baseImage = await _loadBaseImage(path);
    dominantColor = await getDominantColor(baseImage);
    loadImageFromAsset(baseImage).then((value) {
      wallpaper = value;
      notifyListeners();
    });
    loadImageFromAssetAndBlurIt(baseImage).then((value) {
      blurredWallpaper = value;
      notifyListeners();
    });

  }

  Future<Color> getDominantColor(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final bytes = byteData!.buffer.asUint8List();

    final pixelCount = bytes.lengthInBytes ~/ 4;
    final r = List<int>.filled(256, 0);
    final g = List<int>.filled(256, 0);
    final b = List<int>.filled(256, 0);
    for (var i = 0; i < pixelCount; i++) {
      final alpha = bytes[i * 4 + 3];
      if (alpha == 0) {
        continue;
      }
      r[bytes[i * 4]]++;
      g[bytes[i * 4 + 1]]++;
      b[bytes[i * 4 + 2]]++;
    }
    final maxR = r.reduce((value, element) => value > element ? value : element);
    final maxG = g.reduce((value, element) => value > element ? value : element);
    final maxB = b.reduce((value, element) => value > element ? value : element);
    final max = [maxR, maxG, maxB].reduce((value, element) => value > element ? value : element);
    final dominantColor = max == maxR
        ? Color.fromARGB(255, r.indexOf(max), 0, 0)
        : max == maxG
            ? Color.fromARGB(255, 0, g.indexOf(max), 0)
            : Color.fromARGB(255, 0, 0, b.indexOf(max));
    return dominantColor;
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
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..imageFilter = ui.ImageFilter.blur(sigmaX: 200, sigmaY: 200);
    canvas.drawImage(image, Offset.zero, paint);
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return Image.memory(buffer);
  }
}
