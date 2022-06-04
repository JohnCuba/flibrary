import 'package:flibrary/src/domain/controllers/main_navigation.controller.dart';
import 'package:flibrary/src/presentation/screens/main/components/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final mainNavigationController = Get.find<MainNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Sidebar(),
        Expanded(
            child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(24),
            child: Navigator(
              key: Get.nestedKey(1),
              onGenerateRoute: mainNavigationController.onGenerateRoute,
            ),
          ),
        ))
      ],
    );
  }
}
