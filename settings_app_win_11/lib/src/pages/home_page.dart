import 'package:flutter/material.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:provider/provider.dart';
import 'package:settings_app_win_11/src/widgets/side_bar.dart';

class SettingsProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setTab(int s) {
    _selectedIndex = s;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // const displayMode = PaneDisplayMode.open;
    // return ChangeNotifierProvider(
    //     create: (context) => SettingsProvider(),
    //     builder: (context, _) {
    //       final settingsProvider = context.watch<SettingsProvider>();
    //       return NavigationView(
    //         appBar: const NavigationAppBar(
    //           title: Text('Settings'),
    //         ),
    //
    //         pane: NavigationPane(
    //           selected: settingsProvider.selectedIndex,
    //           onItemPressed: (index) {},
    //           onChanged: settingsProvider.setTab,
    //           displayMode: displayMode,
    //
    //           items: [
    //             PaneItem(
    //               icon: const Icon(Icons.home),
    //               title: const Text('Home'),
    //
    //               body: const SizedBox(),
    //             ),
    //             // PaneItemSeparator(),
    //             PaneItem(
    //               icon: const Icon(Icons.add),
    //               title: const Text('Track orders'),
    //               infoBadge: const InfoBadge(source: Text('8')),
    //               body: Container(
    //                 child: Text(
    //                   'Badging is a non-intrusive and intuitive way to display '
    //                       'notifications or bring focus to an area within an app - '
    //                       'whether that be for notifications, indicating new content, '
    //                       'or showing an alert. An InfoBadge is a small piece of UI '
    //                       'that can be added into an app and customized to display a '
    //                       'number, icon, or a simple dot.',
    //                 ),
    //               ),
    //             ),
    //             PaneItem(
    //               icon: const Icon(Icons.settings),
    //               title: const Text('Settings'),
    //               body: const SizedBox(),
    //             ),
    //             PaneItemAction(
    //               icon: const Icon(Icons.add),
    //               title: const Text('Add New Item'),
    //               onTap: () {
    //                 // Your Logic to Add New `NavigationPaneItem`
    //
    //                 settingsProvider.setTab(0);
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          const SideBar(),
          Expanded(
              child: SingleChildScrollView(
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
