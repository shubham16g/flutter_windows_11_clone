import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import '../win_11/common_widgets/app_background.dart';
import '../win_11/common_widgets/appbar_corner_buttons.dart';

class FileExplorerApp extends App {
  @override
  String get title => 'File Explorer';

  @override
  Widget get icon => SvgPicture.asset(
        'assets/icons/file_explorer_app.svg',
        width: 24,
      );

  @override
  bool get isMultiInstance => true;

  @override
  Widget builder(BuildContext context, Rect rect) {
    final appController = context.watch<AppController>();
    return AppBackground(
      isFullScreen: appController.isFullScreen,
      isFocused: appController.isFocused,
      child: Column(
        children: [
          AppTitleBar(trailing: AppbarCornerButtons(isDark: context.isDark)),
        ],
      ),
    );
  }
}

class EdgeApp extends App {
  @override
  String get title => 'Edge';

  @override
  Widget get icon => SvgPicture.asset(
        'assets/icons/edge_app.svg',
        width: 30,
      );

  @override
  Widget builder(BuildContext context, Rect rect) {
    return Container(
      color: Colors.red,
    );
  }
}

class CopilotApp extends App {
  @override
  String get title => 'Copilot';

  @override
  Widget get icon => const Icon(Icons.assistant);

  @override
  Widget builder(BuildContext context, Rect rect) {
    return Container(
      color: Colors.red,
    );
  }
}