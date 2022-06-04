import 'package:flibrary/src/data/local/service/catalogs_meta.service.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:get/get.dart';

class CatalogsMetaController extends GetxController {
  final Rx<CatalogsMetaService> _catalogs = CatalogsMetaService().obs;
  final _current = Rxn<CatalogMeta?>();

  CatalogMeta? get current {
    return _current.value;
  }

  List<CatalogMeta> getAll() {
    return _catalogs.value.all;
  }

  remove() {
    _catalogs.value.remove(_current.value!.id);
  }

  updateId(String? id) {
    _current.value =
        _catalogs.value.all.firstWhereOrNull((catalog) => catalog.id == id);
  }

  saveCatalog(String url, Map<String, String>? headers) {
    _catalogs.value.add(url: url, headers: headers);
  }
}
