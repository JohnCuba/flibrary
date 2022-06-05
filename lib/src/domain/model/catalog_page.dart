import 'package:flibrary/src/domain/model/catalog_entry.dart';

class CatalogPage {
  final String title;
  final String? searchUrl;
  final List<CatalogEntry> entries;

  CatalogPage({required this.title, this.searchUrl, required this.entries});
}
