import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:os_win_11/src/utils/ui_utils.dart';
import 'package:os_win_11/src/colors/os_extension_on_colors.dart';
import 'package:os_core/os_core.dart';

import '../../common_widgets/app_background.dart';
import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';
import '../../common_widgets/required_fluent_ui_components.dart';

class TaskbarControlMenu extends StatelessWidget
    implements PreferredSizeWidget {
  const TaskbarControlMenu({super.key});

  final bottomMargin = 16.0;

  @override
  Size get preferredSize => Size(360, 394 + bottomMargin);

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      glassBlur: true,
      boxShadow: const [],
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: context.osColor.glassOverlay1,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 13,
                            mainAxisExtent: 96,
                            crossAxisCount: 3),
                    children: [
                      Builder(builder: (context) {
                        final wifiController = OsWifiController.watch(context);
                        return item(context,
                            child: const Icon(FluentIcons.wifi_1_24_regular),
                            isActive: wifiController.isWifiOn,
                            onTap: wifiController.toggleWifi,
                            title: 'Wi-Fi');
                      }),
                      Builder(builder: (context) {
                        final btController =
                            OsBluetoothController.watch(context);
                        return item(context,
                            child: const Icon(FluentIcons.bluetooth_24_regular),
                            isActive: btController.isBluetoothOn,
                            onTap: btController.toggleWifi,
                            title: 'Bluetooth');
                      }),
                      Builder(builder: (context) {
                        final themeController =
                            OsNightLightController.watch(context);
                        return item(context,
                            child: const Icon(
                                FluentIcons.brightness_low_24_regular),
                            isActive: themeController.isNightLightOn,
                            onTap: themeController.toggleNightLight,
                            title: 'Night light');
                      }),
                      Builder(builder: (context) {
                        final batteryController =
                            OsBatteryController.watch(context);
                        return item(context,
                            child: const Icon(
                                FluentIcons.battery_saver_24_regular),
                            isActive: batteryController.isBatterySaverOn,
                            onTap: batteryController.toggleBatterySaver,
                            title: 'Battery saver');
                      }),
                      Builder(builder: (context) {
                        final themeController =
                            OsThemeController.watch(context);
                        return item(context,
                            child:
                                const Icon(FluentIcons.dark_theme_24_regular),
                            isActive: themeController.isDarkMode,
                            onTap: themeController.toggleTheme,
                            title: 'Dark Theme');
                      }),
                      item(context,
                          child: Icon(FluentIcons.settings_24_regular),
                          title: 'Settings',
                          onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const _BrightnessControl(),
                  const SizedBox(height: 14),
                  const _VolumeControl(),
                ],
              ),
            ),
          ),
          Container(
            color: context.osColor.glassOverlay2,
            height: 48,
          ),
        ],
      ),
    ).pad(bottom: bottomMargin);
  }

  Widget item(BuildContext context,
      {required Widget child,
      required String title,
      bool isActive = false,
      void Function()? onTap,
      bool useGlassButton = true}) {
    return Column(
      children: [
        useGlassButton
            ? GlassButton(
                isFocused: true,
                isActive: isActive,
                onPressed: onTap,
                width: double.infinity,
                height: 48,
                child: child,
              )
            : child,
        const SizedBox(height: 7),
        Flexible(
            child: Text(
          title,
          style: context.theme.typography.caption,
          maxLines: 2,
        )),
      ],
    );
  }
}

class _BrightnessControl extends StatelessWidget {
  const _BrightnessControl({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessController = OsBrightnessController.watch(context);
    return Row(
      children: [
        Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: const Icon(FluentIcons.brightness_high_20_regular)),
        const SizedBox(width: 2),
        Expanded(
          child: FluentSlider(
              label: brightnessController.brightness.toString(),
              value: brightnessController.brightness.toDouble(),
              onChanged: (value) {
                brightnessController.setBrightness(value.toInt());
              }),
        ),
        const SizedBox(width: 2),
        const SizedBox(width: 40, height: 40),
      ],
    );
  }
}

class _VolumeControl extends StatelessWidget {
  const _VolumeControl({super.key});

  @override
  Widget build(BuildContext context) {
    final volumeController = OsVolumeController.watch(context);
    return Row(
      children: [
        const GlassButton(
            width: 40,
            height: 40,
            showOutline: false,
            child: Icon(FluentIcons.speaker_2_20_regular)),
        const SizedBox(width: 2),
        Expanded(
          child: FluentSlider(
              label: volumeController.volume.toString(),
              value: volumeController.volume.toDouble(),
              onChanged: (value) {
                volumeController.setVolume(value.toInt());
              }),
        ),
        const SizedBox(width: 2),
        const GlassButton(
            width: 40,
            height: 40,
            showOutline: false,
            child: Icon(FluentIcons.arrow_right_20_filled)),
      ],
    );
  }
}

class TaskbarControlMenuButton extends StatelessWidget {
  const TaskbarControlMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        exitAnim: CustomOverlayAnim.slide,
        barrierColor: Colors.transparent,
        decoration: BoxDecoration(
          boxShadow: AppBackground.defaultBoxShadow(context),
        ),
        overlayBuilder: (context) => const TaskbarControlMenu(),
        builder: (context, callback) {
          return GlassButton(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 4.5),
            onPressed: () {
              callback.showOverlay();
            },
            child: IconTheme(
              data: context.theme.iconTheme.copyWith(size: 20),
              child: const Row(
                children: [
                  Icon(FluentIcons.wifi_1_20_regular),
                  SizedBox(width: 4),
                  Icon(FluentIcons.speaker_2_20_regular),
                  SizedBox(width: 4),
                  Icon(FluentIcons.battery_5_20_regular),
                ],
              ),
            ),
          );
        });
  }
}
