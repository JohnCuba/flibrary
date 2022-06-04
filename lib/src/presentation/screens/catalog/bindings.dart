import 'package:flibrary/src/domain/controllers/catalog.controller.dart';
import 'package:flibrary/src/domain/controllers/catalogs_meta.controller.dart';
import 'package:get/get.dart';

class CatalogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CatalogsMetaController());
    Get.lazyPut(() => CatalogController());
  }
}
