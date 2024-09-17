import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/main_page.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/widgets/grain_blur_bg.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF757575).withOpacity(0.6),
            width: 1,
          ),
        )
      ),
      child: Stack(
        children: [
          GrainBlurBg(),
        ],
      ),
    );
  }
}
