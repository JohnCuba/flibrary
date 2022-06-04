import 'package:flibrary/src/domain/model/catalog_meta.dart';

class CatalogMetaData {
  static CatalogMeta fromJson(dynamic json) {
    return CatalogMeta(
        id: json['id'] as String,
        url: json['url'] as String,
        headers: Map<String, String>.from(json['headers']));
  }
}
