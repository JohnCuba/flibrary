import 'dart:io';
import 'package:flibrary/const/enum.dart';
import 'package:flibrary/stores/device.dart';
import 'package:flibrary/stores/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class EntryModel extends ChangeNotifier {
  final Future<http.Response> Function([String? path]) fetchFromLibrary;
  final String pathForFiles;
  late final XmlElement _element;
  late ImageProvider<Object>? cover;
  late String _format;

  EntryModel(
    this._element,
    {
      required this.fetchFromLibrary,
      required this.pathForFiles,
    }
  ) {
    
    cover = null;
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
        break;
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

  bool _getLinkByFormat(XmlElement element) {
    // TODO: I think it can be better
    try {
      return supportedFileTypes.firstWhere(
        (type) {
          String? elementType = element.getAttribute('type');
          String linkType = 'application/$type';
          bool isRightFormat = elementType == linkType || elementType == '$linkType+zip';
          if (isRightFormat) {
            _format = type;
          }
          return isRightFormat;
        }
      ).isNotEmpty;
    } catch (error) {
      return false;
    }
  }

  String? _getDownloadLink() {
    try {
      return _element
        .findAllElements('link')
        .firstWhere(_getLinkByFormat)
        .getAttribute('href');
    } catch (error) {
      return null;
    }
  }

  void downloadBook() async {
    try {
      await fetchFromLibrary(_getDownloadLink())
        .then((response) {
          File('$pathForFiles/$title.$_format')
            .writeAsBytesSync(response.bodyBytes);
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
    (ref, element) => EntryModel(
      element,
      pathForFiles: ref.read(deviceProvider).dir!.path,
      fetchFromLibrary: ref.read(libraryProvider).fetchFromLibrary
    )
  );