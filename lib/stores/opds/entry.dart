import 'dart:io';
import 'package:flibrary/const/enum.dart';
import 'package:flibrary/stores/device.dart';
import 'package:flibrary/stores/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class EntryModel extends ChangeNotifier {
  final Future<http.StreamedResponse?> Function([String? path]) fetchFromLibrary;
  final String pathForFiles;
  late final XmlElement _element;
  late ImageProvider<Object>? cover;
  double loadingPercent = 0;
  LoadState loadState = LoadState.notStarted;
  final Map<SupportedExtensions, String?> _downloadLinks = {};
  late String _format;

  EntryModel(
    this._element, {
    required this.fetchFromLibrary,
    required this.pathForFiles,
  }) {
    cover = null;
    _getDownloadLinks();
    getCover();
  }

  _getDownloadLinks() {
    try {
      for (var type in SupportedExtensions.values) {
        _downloadLinks[type] = _element
          .findAllElements('link')
          .firstWhere((element) {
            String? elementType = element.getAttribute('type');
            String linkType = 'application/${type.toString().replaceFirst('SupportedExtensions.', '')}';
            return elementType == linkType || elementType == '$linkType+zip';
          }).getAttribute('href');
      }
    } catch (error) {
      return null;
    }
  }

  String get title {
    return _element.getElement('title')!.text;
  }

  OpdsEntryKind get kind {
    try {
      return OpdsEntryKind.values
          .byName(_element.getElement('id')!.text.split(':')[1]);
    } catch (error) {
      return OpdsEntryKind.other;
    }
  }

  String get subtitle {
    switch (kind) {
      case OpdsEntryKind.book:
        return _element.getElement('author')?.getElement('name')?.text ??
            'Автор не указан';
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
      await fetchFromLibrary(_getCoverLink()).then((value) {
        value!.stream.toBytes().then((bytes) {
          cover = Image.memory(bytes).image;
          notifyListeners();
        });
      });
    } catch (error) {
      return null;
    }
  }

  String? _getCoverLink() {
    try {
      return _element
              .findAllElements('link')
              .firstWhere(
                  (element) => element.getAttribute('type') == 'image/jpeg')
              .getAttribute('href');
    } catch (error) {
      return null;
    }
  }

  void downloadBestFormatBook() async {
    try {
      loadState = LoadState.pending;
      notifyListeners();
      _format = _downloadLinks.keys.first.toString().replaceFirst('SupportedExtensions.', '');
      await fetchFromLibrary(_downloadLinks.values.first).then(_parseFile);
    } catch (error) {
      return null;
    }
  }

  _parseFile(http.StreamedResponse? value) {
    loadState = LoadState.load;
    loadingPercent = 0.1;
    List<int> _bytes = [];
    notifyListeners();
    if (value != null) {
      value.stream.listen((bytes) {
        loadingPercent = _bytes.length / value.contentLength!;
        notifyListeners();
        _bytes.addAll(bytes);
      }).onDone(() {
        File('$pathForFiles/$title.$_format').writeAsBytesSync(_bytes);
        loadState = LoadState.done;
        loadingPercent = 0;
      });
    }
  }

  String? get path {
    return _element.getElement('link')?.getAttribute('href');
  }
}

final entryProvider = ChangeNotifierProvider.family<EntryModel, XmlElement>(
    (ref, element) => EntryModel(element,
        pathForFiles: ref.read(deviceProvider).dir!.path,
        fetchFromLibrary: ref.read(libraryProvider).fetchFromLibrary));
