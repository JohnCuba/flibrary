import 'package:flibrary/const/enum.dart';
import 'package:flibrary/stores/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class EntryModel extends ChangeNotifier {
  late final XmlElement _element;
  late ImageProvider<Object>? cover = null;
  final Future<http.Response> Function([String? path]) fetchFromLibrary;

  EntryModel(this._element, {required this.fetchFromLibrary}) {
    getCover();
  }

  String get title {
    return _element.getElement('title')!.text;
  }

  OpdsEntryKind get kind {
    try {
      return OpdsEntryKind.values.byName(_element.getElement('id')!.text.split(':')[1]);
    } catch (error) {
      return OpdsEntryKind.other;
    }
  }

  String get subtitle {
    switch (kind) {
      case OpdsEntryKind.book:
        return _element.getElement('author')!.getElement('name')!.text;
      case OpdsEntryKind.other:
        return _element.getElement('content')?.text ?? '';
    }
  }

  void getCover() {
    switch (kind) {
      case OpdsEntryKind.book:
        _loadCover();
        break;
      case OpdsEntryKind.other:
        return null;
    }
  }

  void _loadCover() async {
    try {
      await fetchFromLibrary(
        _element
          .findAllElements('link')
          .firstWhere((element) => element.getAttribute('type') == 'image/jpeg')
          .getAttribute('href')
      )
        .then((value) {
          cover = Image.memory(value.bodyBytes).image;
          notifyListeners();
        });
    } catch (error) {
      return null;
    }
  }

  String? get path {
    return _element.getElement('link')?.getAttribute('href');
  }
}

final entryProvider = ChangeNotifierProvider
  .family<EntryModel, XmlElement>(
    (ref, element) => EntryModel(element, fetchFromLibrary: ref.read(libraryProvider).fetchFromLibrary)
  );