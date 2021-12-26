import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

class BookModel extends ChangeNotifier {
  BookModel(String file) {
    _file = File(file);
    _parseFile();
  }

  late File _file;
  late EpubBook _book = EpubBook();

  _parseFile() async {
    final bytes = await _file.readAsBytes();
    _book = await EpubReader.readBook(bytes);

    notifyListeners();
  }

  void deleteBook() async {
    await _file.delete();
  }

  String? get title {
    return _book.Title;
  }

  String? get author {
    return _book.Author;
  }

  Uint8List? get cover {
    return _book.CoverImage != null
        ? Uint8List.fromList(encodePng(_book.CoverImage!))
        : null;
  }
}
