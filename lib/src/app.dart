import 'package:flibrary/src/presentation/screens/main/bindings.dart';
import 'package:flibrary/src/presentation/screens/main/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/main',
      getPages: [
        GetPage(
          name: '/main',
          page: () => MainScreen(),
          binding: MainBinding(),
        )
      ],
    );
  }
}
