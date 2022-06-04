import 'package:flibrary/src/presentation/screens/catalog/bindings.dart';
import 'package:flibrary/src/presentation/screens/catalog/screen.dart';
import 'package:flibrary/src/presentation/screens/local_library/bindings.dart';
import 'package:flibrary/src/presentation/screens/local_library/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Route> routes = [
  Route(
    name: '/',
    title: 'Local Library',
    page: () => LocalLibraryScreen(),
    binding: LocalLibraryBinding(),
    icon: Icons.devices_outlined,
  ),
  Route(
    name: '/catalog',
    title: 'Add new library',
    page: () => CatalogScreen(),
    binding: CatalogBinding(),
    icon: Icons.add_circle,
  ),
];

class Route {
  final String title;
  final String name;
  final Widget Function() page;
  final Bindings? binding;
  final IconData icon;
  final Map<String, String>? args;

  Route(
      {required this.title,
      required this.name,
      required this.page,
      this.binding,
      this.args,
      required this.icon});
}
