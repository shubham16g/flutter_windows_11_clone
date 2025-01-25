import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


class YoutubePage extends StatefulWidget {
  final Rect rect;

  const YoutubePage({super.key, required this.rect});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    return AppBackground(
        isFocused: appController.isFocused,
        isFullScreen: appController.isFullScreen,
        rect: widget.rect,
        child: Column(
          children: [
            AppTitleBar(
              leading: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
                trailing: AppbarCornerButtons(isDark: context.isDark)),
            Expanded(
                child: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                      : Container(),
                ))
          ],
        ),
    );
  }
}
