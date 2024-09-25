import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class WallpaperWrapper extends ChangeNotifier {

  Image? wallpaper;
  Image? blurredWallpaper;

  WallpaperWrapper({String? initialPath}) {
    loadWallpaperFromAsset(initialPath ?? 'assets/images/wall_light.jpg');
  }


  Future<void> loadWallpaperFromAsset(String path) async {
    final baseImage = await _loadBaseImage(path);
    loadImageFromAsset(baseImage).then((value) {
      wallpaper = value;
      notifyListeners();
    });
    loadImageFromAssetAndBlurIt(baseImage).then((value) {
      blurredWallpaper = value;
      notifyListeners();
    });

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
      ..imageFilter = ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50);
    canvas.drawImage(image, Offset.zero, paint);
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return Image.memory(buffer);
  }
}
