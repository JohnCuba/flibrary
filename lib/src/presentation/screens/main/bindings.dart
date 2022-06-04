import 'package:flibrary/src/domain/controllers/main_navigation.controller.dart';
import 'package:flibrary/src/domain/controllers/catalogs_meta.controller.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavigationController());
    Get.lazyPut(() => CatalogsMetaController());
  }
}
