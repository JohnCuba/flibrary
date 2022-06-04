import 'package:flibrary/src/data/opds/service/catalog.service.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:flibrary/src/domain/model/catalog_page.dart';
import 'package:get/get.dart';

class CatalogController extends GetxController {
  late CatalogService _catalogService;
  final _page = Rxn<CatalogPage>();

  CatalogPage? get page {
    return _page.value;
  }

  updateMeta(CatalogMeta? meta) {
    if (meta != null) {
      _catalogService = CatalogService(meta);
      updatePage('');
    }
  }

  updatePage(String path) async {
    _page.value = await _catalogService.getPage(path);
  }
}
