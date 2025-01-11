import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:provider/provider.dart';


class YoutubePage extends StatelessWidget {
  final Rect rect;

  const YoutubePage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    return AppBackground(
        isFocused: appController.isFocused,
        isFullScreen: appController.isFullScreen,
        rect: rect,
        child: Column(
          children: [
            AppTitleBar(trailing: AppbarCornerButtons(isDark: context.isDark)),
            Expanded(
                child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InAppWebView(
                preventGestureDelay: true,
                initialUrlRequest: URLRequest(
                  url: WebUri('https://shubho-youtube-mern.netlify.app/'),
                ),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  useOnLoadResource: true,
                  cacheEnabled: true,
                ),
                onWebViewCreated: (controller) {
                  // _webViewController = controller;
                },
              ),
            ))
          ],
        ),
    );
  }
}
