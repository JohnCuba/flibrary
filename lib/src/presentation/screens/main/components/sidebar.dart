import 'package:flibrary/src/domain/controllers/main_navigation.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  final mainNavigationController = Get.find<MainNavigationController>();

  Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationRail(
          destinations: mainNavigationController.pages
              .map((page) => NavigationRailDestination(
                  icon: Icon(page.icon),
                  selectedIcon: Icon(page.icon),
                  label: Text(page.title)))
              .toList(),
          selectedIndex: mainNavigationController.currentIndex.value,
          onDestinationSelected: mainNavigationController.changePage,
        ));
  }
}
