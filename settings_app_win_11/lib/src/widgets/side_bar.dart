import 'package:flutter/material.dart';
import 'package:os_win_11/os_win_11.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 306,
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GlassButton(
              showOutline: false,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.osColor.textSecondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.osColor.taskbarBorder.withOpacity(0.03),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(FluentIcons.person_32_filled,
                        size: 40,
                        color: context.osColor.appBackground),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shubham Gupta',
                          style: context.theme.typography.caption?.copyWith(
                              color: context.osColor.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('shubham16g@gmail.com',
                          style: context.theme.typography.caption?.copyWith(
                              color: context.osColor.textPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
              onPressed: () {
              },
            ),
          ),
          TextFormBox(
            placeholder:
            'Find a setting',
          ).pad(left: 20, right: 6, top: 20, bottom: 20),
          Expanded(child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 6),
            child: SizedBox(),
          ))

        ],
      ),
    );
  }
}
