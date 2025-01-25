import 'package:ecom/main.dart' as ecom;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:os_core/os_core.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';


const mApp = ecom.MyApp();

class FileExplorerApp extends App {
  @override
  String get title => 'File Explorer';

  @override
  Widget get icon =>
      SvgPicture.asset('assets/icons/file_explorer_app.svg', width: 24);

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
          PointerInterceptor(
            child: AppTitleBar(
                leading: CustomOverlayAnimated(
                    barrierColor: Colors.transparent,
                    overlayBuilder: (context) {
                      return const PreferredSize(
                        preferredSize: Size(100, 220),
                        child: GlassBlurBg(),
                      );
                    },
                    builder: (context, callback) {
                      return GlassButton(
                        onPressed: () {
                          callback.showOverlay();
                        },
                        isFocused: false,
                        child: const Text('19:32'),
                      );
                    }),
                trailing: AppbarCornerButtons(isDark: context.isDark)),
          ),
          const Expanded(child: ClipRect(child: mApp))
        ],
      ),
    );
  }
}

class EdgeApp extends App {
  @override
  String get title => 'Edge';

  @override
  Widget get icon => SvgPicture.asset('assets/icons/edge_app.svg', width: 30);

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
