import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flibrary/src/data/local/model/catalog_meta.data.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xml/xml.dart';

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

  add({required String url, Map<String, String>? headers}) async {
    final list = all;
    final dio = Dio(BaseOptions(baseUrl: url, headers: headers));
    final document =
        XmlDocument.parse(await dio.get('').then((value) => value.data));
    list.add(CatalogMeta(
        id: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        title: document.findAllElements('title').first.text,
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
