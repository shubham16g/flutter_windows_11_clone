import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:flutter_windows_11_clone/widgets/grain_blur_bg.dart';
import 'package:provider/provider.dart';

import '../app/controller/app_controller.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsProvider>();
    final taskbarApps = runningAppsProvider.taskbarApps;
    final focusedApp = runningAppsProvider.focusedApp;
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: const Color(0xFF757575).withOpacity(0.6),
          width: 1,
        ),
      )),
      child: Stack(children: [
        const GrainBlurBg(),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.window),
              ...taskbarApps.map((e) => TaskbarButton(
                  isFocused: focusedApp == e.app,
                  openCount: e.openCount,
                  onPressed: () {
                    final rap = context.read<RunningAppsProvider>();
                    if (e.openCount <= 0) {
                      rap.openApp(
                          Container(
                            width: 600,
                            height: 600,
                          ),
                          AppController(
                              cursorController: context.read(), app: e.app));
                    } else if (!rap.isFocused(e.app)) {
                      rap.focusByApp(e.app);
                    } else {
                      rap.toggleMinimizeMaximizeByApp(e.app);
                    }
                  },
                  icon: e.app.icon))
            ],
          ),
        )
      ]),
    );
  }
}

class TaskbarButton extends StatefulWidget {
  final Widget icon;
  final bool isFocused;
  final int openCount;
  final VoidCallback onPressed;

  const TaskbarButton(
      {super.key,
      required this.icon,
      required this.isFocused,
      required this.openCount,
      required this.onPressed});

  @override
  State<TaskbarButton> createState() => _TaskbarButtonState();
}

class _TaskbarButtonState extends State<TaskbarButton> {
  bool isHovered = false;
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              isTapDown = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isTapDown = false;
            });
          },
          onTapCancel: () {
            setState(() {
              isTapDown = false;
            });
          },
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isHovered && widget.isFocused
                  ? 0.08
                  : widget.isFocused
                      ? 0.06
                      : isHovered
                          ? 0.05
                          : 0),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: const Color(0xFFFFFFFF)
                      .withOpacity(isHovered && widget.isFocused
                          ? 0.15
                          : widget.isFocused
                              ? 0.1
                              : isHovered
                                  ? 0.08
                                  : 0),
                  width: 0.5),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      scale: isTapDown ? 0.7 : 1,
                      child: widget.icon),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    width: widget.openCount == 0
                        ? 0
                        : widget.isFocused
                            ? 16
                            : 6,
                    height: 3,
                    decoration: BoxDecoration(
                      color: widget.isFocused
                          ? Colors.blue
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
