import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_blur_bg.dart';
import 'package:intl/intl.dart';

import '../../common_widgets/app_background.dart';
import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';
import '../../common_widgets/slide_anim_wrapper.dart';

class TaskbarClockNotification extends StatelessWidget {
  const TaskbarClockNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        screenSideMargin: const EdgeInsets.all(1),
        exitAnim: CustomOverlayAnim.slide,
        slideAnimDirection: SlideAnimDirection.right,
        barrierColor: Colors.transparent,
        overlayBuilder: (context) {
          return PreferredSize(
            preferredSize: Size(340, context.screenSize.height - 48 - 16),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16),
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  const SizedBox(height: 16),
                  _Calender()
                ],
              ),
            ),
          );
        },
        builder: (context, callback) {
          return GlassButton(
            height: 40,
            padding: const EdgeInsets.only(left: 8, right: 6.5),
            onPressed: () {
              callback.showOverlay();
            },
            isFocused: false,
            child: const Row(
              children: [
                _Clock(),
                SizedBox(width: 5),
                Icon(FluentIcons.alert_20_regular, size: 18),
              ],
            ),
          );
        });
  }
}

class _Clock extends StatefulWidget {
  const _Clock({super.key});

  @override
  State<_Clock> createState() => _ClockState();
}

class _ClockState extends State<_Clock> {
  String timeString = ''; // hh:mm
  String dateString = ''; // dd-mm-yyyy

  final _timeFormat = DateFormat('HH:mm');
  final _dateFormat = DateFormat('dd-MM-yyyy');

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeString = _timeFormat.format(DateTime.now());
        dateString = _dateFormat.format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(timeString, style: context.theme.typography.caption),
        Text(dateString, style: context.theme.typography.caption),
      ],
    );
  }
}

class _Calender extends StatefulWidget {
  const _Calender({super.key});

  @override
  State<_Calender> createState() => _CalenderState();
}

class _CalenderState extends State<_Calender> {
  bool _isExpanded = true;

  set isExpanded(bool value) {
    setState(() {
      _isExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      backgroundColor: Colors.transparent,
      borderColor: context.osColor.taskbarBorder,
      child: Column(
        children: [
          Container(
            height: 48,
            color: context.osColor.glassOverlay2,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text('Calendar', style: context.theme.typography.caption),
                const Spacer(),
                IconButton(
                  icon: Icon(_isExpanded
                      ? FluentIcons.chevron_up_20_regular
                      : FluentIcons.chevron_down_20_regular),
                  onPressed: () {
                      isExpanded = !_isExpanded;
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ).glassBlurBg(),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            child: _isExpanded ? Container(
              height: 322,
              color: context.osColor.glassOverlay1,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                currentDate: DateTime.now(),
                firstDate: DateTime.now().copyWith(year: 2021),
                lastDate: DateTime.now().copyWith(year: 2222),
                onDateChanged: (date) {
                  print(date);
                },
              ),
            ) : const SizedBox(width: double.infinity,),
          ).glassBlurBg(),
        ],
      ),
    );
    // return GridView(gridDelegate: gridDelegate);
  }
}
