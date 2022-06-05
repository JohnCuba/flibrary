import 'package:dio/dio.dart';
import 'package:flibrary/src/data/opds/model/catalog_page.data.dart';
import 'package:flibrary/src/domain/model/catalog_meta.dart';
import 'package:flibrary/src/domain/model/catalog_page.dart';

class CatalogService {
  late final Dio _dio;

  CatalogService(CatalogMeta meta) {
    _dio = Dio(BaseOptions(baseUrl: meta.url, headers: meta.headers));
  }

  Future<CatalogPage> getPage(String path) async {
    return CatalogPageData.fromXml(
        await _dio.get(path).then((value) => value.data));
  }
}
