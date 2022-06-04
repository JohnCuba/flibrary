import 'dart:convert';

class CatalogMeta {
  final String id;
  final String url;
  final Map<String, String>? headers;

  CatalogMeta({required this.id, required this.url, required this.headers});

  @override
  String toString() {
    return '{"id": "${id.toString()}", "url": "$url", "headers": ${jsonEncode(headers)}}';
  }
}
