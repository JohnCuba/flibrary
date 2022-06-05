import 'package:flibrary/src/data/opds/service/catalog.service.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:flibrary/src/domain/model/catalog_page.dart';
import 'package:flibrary/src/utils/trim_protocol_from_path.dart';
import 'package:get/get.dart';

class CatalogController extends GetxController {
  late CatalogService _catalogService;
  final _page = Rxn<CatalogPage>();
  final _history = [''].obs;

  CatalogPage? get page {
    return _page.value;
  }

  updateMeta(CatalogMeta? meta) async {
    if (meta != null) {
      _catalogService = CatalogService(meta);
      await _updatePage();
    }
  }

  void search(String value) async {
    _history.add(trimProtocolFromPath('${_page.value?.searchUrl}$value'));
    await _updatePage();
  }

  void toPage(String path) async {
    _history.add(trimProtocolFromPath(path));
    await _updatePage();
  }

  void toHome() async {
    _history.removeRange(1, _history.length);
    await _updatePage();
  }

  void toPrevPage() async {
    if (_history.length > 1) {
      _history.removeLast();
      await _updatePage();
    }
  }

  _updatePage() async {
    _page.value = await _catalogService.getPage(_history.last);
  }
}
