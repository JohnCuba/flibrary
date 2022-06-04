import 'dart:convert';
import 'package:flibrary/src/data/local/model/catalog_meta.data.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:get_storage/get_storage.dart';

class CatalogsMetaService {
  final _storageKey = 'catalogs';
  final _storage = GetStorage();

  listen(void Function(dynamic) onChange) {
    _storage.listenKey(_storageKey, onChange);
  }

  List<CatalogMeta> get all {
    String? storageValue = _storage.read(_storageKey);
    return parseString(storageValue);
  }

  parseString(String? value) {
    if (value == null) return [];

    List<dynamic> rawList = jsonDecode(value);
    return rawList.map((e) => CatalogMetaData.fromJson(e)).toList();
  }

  set _all(List<CatalogMeta> value) {
    _storage.write(_storageKey, '[${value.join(',')}]');
  }

  add({required String url, Map<String, String>? headers}) {
    final list = all;
    list.add(CatalogMeta(
        id: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        url: url,
        headers: headers));

    _all = list;
  }

  remove(String id) {
    final list = all;
    list.removeWhere((catalog) => catalog.id == id);

    _all = list;
  }

  CatalogMeta? getById(String id) {
    return all.firstWhere((element) => element.id == id);
  }
}
