import 'package:flibrary/src/domain/model/catalog_page.dart';
import 'package:xml/xml.dart';

class CatalogPageData {
  static CatalogPage fromXml(String sourceString) {
    var document = XmlDocument.parse(sourceString);
    return CatalogPage(title: document.findAllElements('title').first.text);
  }
}
