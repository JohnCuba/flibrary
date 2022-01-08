import 'package:flibrary/stores/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class OpdsModel extends ChangeNotifier {
  OpdsModel({required this.fetchFromLibrary}) {
    _loadMainPage();
  }

  final Future<http.Response> Function([String? path]) fetchFromLibrary;
  late List<XmlElement> entries = [];
  List<String> history = [];
  late String pathTitle = '';

  void _loadMainPage() async {
    await fetchFromLibrary()
      .then((value) {
        XmlDocument document = XmlDocument.parse(value.body);
        _updatePage(document);
      });
  }

  void goToPath(String path) async {
    history.add(path);
    return await fetchFromLibrary(path)
      .then((value) {
        XmlDocument document = XmlDocument.parse(value.body);
        _updatePage(document);
      });
  }

  void goPrevPath() async {
    history.removeLast();
    return await fetchFromLibrary(history.isNotEmpty ? history.last : null)
      .then((value) {
        XmlDocument document = XmlDocument.parse(value.body);
        _updatePage(document);
      });
  }

  void _updatePage(XmlDocument document) {
    pathTitle = document.findAllElements('title').first.text;
    entries.clear();
    entries = document.findAllElements('entry').toList();
    notifyListeners();
  }
}
// TODO: A OpdsModel was used after being disposed.
final opdsProvider = ChangeNotifierProvider
  ((ref) => OpdsModel(fetchFromLibrary: ref.watch(libraryProvider).fetchFromLibrary));