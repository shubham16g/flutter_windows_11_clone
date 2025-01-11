import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_app_win_11/src/router.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Center(
        child: Text('ThemePage: $count')
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          count++;
        });
      },
      child: Icon(Icons.add),),
    );
  }
}
