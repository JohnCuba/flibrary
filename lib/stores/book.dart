import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

class BookModel extends ChangeNotifier {
  BookModel(String file) {
    _file = File(file);
    _parseFile();
  }

  late File _file;
  EpubBookRef? _book;
  late Uint8List? _cover;

  _parseFile() async {
    _book = await EpubReader.openBook(_file.readAsBytes());
    notifyListeners();
    // _parseCover();
  }

  _parseCover() async {
    if (_book != null) {
      var _stream = await _book!.readCover();
      _cover = Uint8List.fromList(encodePng(_stream!));
      notifyListeners();
    }
  }

  void deleteBook() async {
    _file.delete();
  }

  String? get title {
    return _book != null ? _book!.Title : '';
  }

  String? get author {
    return _book != null ? _book!.Author : '';
  }

  Uint8List? get cover {
    return _book != null ? _cover : null;
  }
}

final bookProvider = ChangeNotifierProvider.autoDispose
    .family<BookModel, String>((ref, file) => BookModel(file));