import 'package:xml/xml.dart';

String? getSearchLink(XmlDocument document) {
  return document
      .findAllElements('link')
      .firstWhere((element) => ((element.getAttribute('rel') == 'search') &&
          (element.getAttribute('type') == 'application/atom+xml')))
      .getAttribute('href')
      ?.replaceFirst('{searchTerms}', '');
}
