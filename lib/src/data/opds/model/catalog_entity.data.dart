import 'package:flibrary/src/domain/model/catalog_entry.dart';
import 'package:xml/xml.dart';

class CatalogEntityData {
  static CatalogEntry fromXmlElement(XmlElement element) {
    return CatalogEntry(
        title: element.findAllElements('title').first.text,
        content: _parseContent(element),
        catalogLink: _parseCatalogLink(element));
  }

  static String? _parseContent(XmlElement element) {
    var contentElements = element.findAllElements('content');
    return contentElements.isNotEmpty ? contentElements.first.text : null;
  }

  static String? _parseFileLink(XmlElement element) {
    var linkElements = element.findAllElements('link');
  }

  static String? _parseCatalogLink(XmlElement element) {
    var linkElements = element.findAllElements('link');
    return linkElements
        .firstWhere(
            (element) => element
                .getAttribute('type')!
                .startsWith('application/atom+xml;'),
            orElse: () => XmlElement(XmlName('vuid')))
        .getAttribute('href');
  }
}
