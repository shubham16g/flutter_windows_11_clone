import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import '../../win_11/common_widgets/app_background.dart';
import '../../win_11/common_widgets/appbar_corner_buttons.dart';

class YoutubePage extends StatelessWidget {
  final Rect rect;

  const YoutubePage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final themeController = context.watch<OsThemeController>();
    return AppBackground(
      blurBackground: true,
      isFocused: appController.isFocused,
      isFullScreen: appController.isFullScreen,
      rect: rect,
      child: Column(
        children: [
          AppTitleBar(trailing: AppbarCornerButtons(isDark: context.isDark)),
          Expanded(
              child:
                  /*WebV()*/ InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://shubho-youtube-mern.netlify.app/', forceToStringRawValue: true),
              allowsExpensiveNetworkAccess: true,
              allowsConstrainedNetworkAccess: true,
            ),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              useOnLoadResource: true,
              cacheEnabled: true,
            ),
            onWebViewCreated: (controller) {
              // _webViewController = controller;
            },
          )
              )
        ],
      ),
    );
  }
}