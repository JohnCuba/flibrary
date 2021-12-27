import 'package:flibrary/screens/settings.dart';
import 'package:flutter/material.dart';
import './device.dart';
import './library.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          actions: const [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                    child: Icon(
                  Icons.devices_rounded,
                  color: Colors.black,
                )),
                Tab(
                    icon: Icon(
                  Icons.library_books,
                  color: Colors.black,
                )),
                Tab(
                    icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                )),
              ],
            ),
          ],
        ),
        body: const TabBarView(
          children: [DeviceScreen(), LibraryScreen(), SettingsScreen()],
        ),
      ),
    );
  }
}
