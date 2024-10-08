import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/apps/youtube/youtube_page.dart';
import 'package:os_core/os_core.dart';

class YoutubeApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => SvgPicture.asset(
    'assets/icons/youtube_app.svg',
    width: 30,
  );

  @override
  double get initialHeight => 800;

  @override
  double get initialWidth => 1000;

  @override
  Widget builder(BuildContext context, Rect rect) =>  YoutubePage(rect: rect);
}