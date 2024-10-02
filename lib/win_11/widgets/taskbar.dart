import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/custom_overlay_animated.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_button.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import '../common_widgets/glass_blur_bg.dart';

class Taskbar extends StatelessWidget implements PreferredSizeWidget {
  const Taskbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsController>();
    final taskbarApps = runningAppsProvider.taskbarApps;
    final focusedApp = runningAppsProvider.focusedApp;
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: context.osColor.taskbarBorder,
          width: 1,
        ),
      )),
      child: Stack(children: [
        const GlassBlurBg(),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskbarButton(
                icon: SvgPicture.asset(
                  'assets/icons/windows_light.svg',
                  width: 24,
                ),
                onPressed: () {
                  runningAppsProvider.toggleStartMenu();
                },
                openCount: 0,
                isFocused: runningAppsProvider.isStartMenuOpened,
              ),
              ...taskbarApps.map((e) => TaskbarButton(
                  isFocused: focusedApp == e.app,
                  openCount: e.openCount,
                  onPressed: () {
                    App.tryOpen(context, e.app);
                  },
                  icon: e.app.icon))
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 300,
            child: Slider(
                value: runningAppsProvider.temp,
                onChanged: (value) {
                  runningAppsProvider.onChangedTemp(value);
                },
                min: 0,
                max: 1),
          ),
        ),
        Positioned(
          right: runningAppsProvider.temp * 200,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomOverlayAnimated(
                  useBarrier: true,
                  exitAnim: CustomOverlayAnim.slide,
                  barrierColor: Colors.transparent,
                  overlayBuilder: (context) {
                    return  PreferredSize(
                      preferredSize: Size(100, 220),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: GlassBlurBg(
                          child: CustomOverlayAnimated(
                              useBarrier: true,
                              exitAnim: CustomOverlayAnim.slide,
                              barrierColor: Colors.transparent,
                              overlayBuilder: (context) {
                                return const PreferredSize(
                                  preferredSize: Size(100, 220),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: GlassBlurBg(
                                    ),
                                  ),
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
                        ),
                      ),
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
                const SizedBox(height: 3),
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
