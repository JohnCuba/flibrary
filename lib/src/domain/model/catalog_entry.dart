enum Type { catalogEntry, fileEntry }

class CatalogEntry {
  final String title;
  late String? content;
  Type type = Type.catalogEntry;
  late String? catalogLink;
  late String? fileLink;

  CatalogEntry(
      {required this.title, this.content, this.catalogLink, this.fileLink}) {
    if (fileLink != null) {
      type = Type.fileEntry;
    }
  }
}
