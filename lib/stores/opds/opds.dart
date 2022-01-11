import 'dart:convert';
import 'package:flibrary/stores/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class OpdsModel extends ChangeNotifier {
  OpdsModel({required this.fetchFromLibrary}) {
    _loadMainPage();
  }

  final Future<http.StreamedResponse?> Function([String? path])
      fetchFromLibrary;
  late List<XmlElement> entries = [];
  List<String> history = [];
  late String pathTitle = '';
  double loadingPercent = 0;
  final List<int> _bytes = [];

  void _loadMainPage() async {
    await fetchFromLibrary().then(_parsePage);
  }

  void goToPath(String path) async {
    history.add(path);
    return await fetchFromLibrary(path).then(_parsePage);
  }

  void goPrevPath() async {
    history.removeLast();
    return await fetchFromLibrary(history.isNotEmpty ? history.last : null)
        .then(_parsePage);
  }

  _parsePage(http.StreamedResponse? value) {
    if (value != null) {
      value.stream.listen((bytes) {
        loadingPercent = _bytes.length / value.contentLength!;
        notifyListeners();
        _bytes.addAll(bytes);
      }).onDone(() {
        XmlDocument document =
            XmlDocument.parse(const Utf8Decoder().convert(_bytes));
        _bytes.clear();
        loadingPercent = 0;
        _updatePage(document);
      });
    }
  }

  void _updatePage(XmlDocument document) {
    pathTitle = document.findAllElements('title').first.text;
    entries.clear();
    entries = document.findAllElements('entry').toList();
    notifyListeners();
  }
}

// TODO: A OpdsModel was used after being disposed.
final opdsProvider = ChangeNotifierProvider((ref) =>
    OpdsModel(fetchFromLibrary: ref.watch(libraryProvider).fetchFromLibrary));
