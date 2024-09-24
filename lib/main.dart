import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/main_page.dart';
import 'package:flutter_windows_11_clone/os/controllers/cursor_controller.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:provider/provider.dart';

import 'os/controllers/wallpaper_controller.dart';

void main() {
  // ensure
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CursorController()),
        ChangeNotifierProvider(create: (context) => RunningAppsProvider()),
        ChangeNotifierProvider(
            create: (context) => WallpaperWrapper(), lazy: true),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Windows 11 Clone',
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
