import 'package:flutter/material.dart';
import './device.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
                icon: Icon(
              Icons.devices_rounded,
              color: Colors.black,
            )),
            // Tab(
            //     icon: Icon(
            //   Icons.library_books,
            //   color: Colors.black,
            // )),
          ],
        ),
        body: TabBarView(
          children: [
            DeviceScreen(),
            // Icon(Icons.library_books),
          ],
        ),
      ),
    );
  }
}
