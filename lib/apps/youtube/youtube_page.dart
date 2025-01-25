import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';


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
              child: WebViewX(
                initialSourceType: SourceType.html,
                onWebViewCreated: (controller) {
                  controller.loadContent('https://flutter.dev');
                },
                initialContent: '<div style="background: red;"><h2> Hello, world! </h2>', width: rect.width,
                height: rect.height - 40,
              ),
            ))
          ],
        ),
    );
  }
}
