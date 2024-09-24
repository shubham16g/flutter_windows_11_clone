import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

class WallpaperWrapper extends ChangeNotifier {
  final BuildContext context;

  Image? wallpaper;
  Image? blurredWallpaper;

  WallpaperWrapper(this.context) {
    loadImageFromAsset('assets/images/wall_${context.isDark ? 'dark' : 'light'}.jpg').then((value) {
      wallpaper = value;
      notifyListeners();
    });
    loadImageFromAssetAndBlurIt('assets/images/wall_${context.isDark ? 'dark' : 'light'}.jpg').then((value) {
      blurredWallpaper = value;
      notifyListeners();
    });

  }

  Future<Image> loadImageFromAsset(String path) async {
    final byteDataRaw = await DefaultAssetBundle.of(context).load(path);
    final image = await decodeImageFromList(byteDataRaw.buffer.asUint8List());
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    return Image.memory(buffer);
  }

  Future<Image> loadImageFromAssetAndBlurIt(String path) async {
  final byteDataRaw = await DefaultAssetBundle.of(context).load(path);
  final image = await decodeImageFromList(byteDataRaw.buffer.asUint8List());
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()
    ..imageFilter = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  canvas.drawImage(image, Offset.zero, paint);
  final picture = recorder.endRecording();
  final img = await picture.toImage(image.width, image.height);
  final byteData = await img.toByteData(format: ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  return Image.memory(buffer);
}
}
