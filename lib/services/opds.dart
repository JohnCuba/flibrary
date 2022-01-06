import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Opds {
  final http.Client _client = http.Client();
  late XmlDocument _xml;
  late Uri _uri;
  late Map<String, String> _headers;

  Opds(String uri, [Map<String, String>? headers]) {
    _uri = Uri.parse(uri).normalizePath();
    _headers = headers ?? {};

    getXml();
  }

  void getXml([String path = '']) async {
    await _client
      .get(_uri, headers: _headers)
      .then((value) {
        _xml = XmlDocument.parse(value.body);
      });
  }
}