import 'package:flibrary/src/data/local/service/catalogs_meta.service.dart';
import 'package:flibrary/src/presentation/screens/catalog/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flibrary/src/routing/main_routing.dart' as main_routing;

class MainNavigationController extends GetxController {
  static MainNavigationController get to => Get.find();
  final CatalogsMetaService _catalogsMetaService = CatalogsMetaService();
  var currentIndex = 0.obs;
  final pages = main_routing.routes.obs;

  MainNavigationController() {
    updateCatalogs(null);
    _catalogsMetaService.listen(updateCatalogs);
  }

  void updateCatalogs(dynamic value) {
    var catalogPages = _catalogsMetaService.all
        .map((e) => main_routing.Route(
            title: e.url,
            name: '/catalog',
            page: () => CatalogScreen(),
            icon: Icons.library_books_outlined,
            args: {'id': e.id}))
        .toList();

    var preparedRoutes = [
      ...main_routing.routes,
      ...catalogPages,
    ];

    changePage(0); // TODO: Make redirect more user friendly

    pages.assignAll(preparedRoutes);
  }

  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      Get.offAndToNamed(pages[index].name, arguments: pages[index].args, id: 1);
    }
  }

  Route onGenerateRoute(RouteSettings settings) {
    final main_routing.Route? page =
        pages.firstWhereOrNull((element) => element.name == settings.name);

    Get.routing.args = settings.arguments;

    return GetPageRoute(
      settings: settings,
      routeName: page?.name,
      page: page?.page,
      binding: page?.binding,
    );
  }
}
