import 'package:flibrary/src/data/opds/model/catalog_entity.data.dart';
import 'package:flibrary/src/domain/model/catalog_page.dart';
import 'package:flibrary/src/utils/get_search_link.dart';
import 'package:xml/xml.dart';

class CatalogPageData {
  static CatalogPage fromXml(String sourceString) {
    var document = XmlDocument.parse(sourceString);
    return CatalogPage(
        title: document.findAllElements('title').first.text,
        searchUrl: getSearchLink(document),
        entries: document
            .findAllElements('entry')
            .map((element) => CatalogEntityData.fromXmlElement(element))
            .toList());
  }
}
