import 'package:flutter/material.dart';
import 'package:settings_app_win_11/src/widgets/side_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          const SideBar(),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 14, right: 20),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 998,
                ),
                height: 1000,
                color: Colors.blue.withOpacity(0.2),

              ),
            ),
          ))
        ],
      ),
    );
  }
}
